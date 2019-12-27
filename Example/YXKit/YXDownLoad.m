//
//  YXDownLoad.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/30.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "YXDownLoad.h"
#import <AFNetworking.h>
#import "YYKit.h"
@interface YXDownLoad()<NSURLSessionDataDelegate>

// session
@property (nonatomic, strong)NSURLSession *session;

// set appropriate download length for onece
@property (nonatomic, assign)long long perDownloadLength;

// an request url form server
@property (nonatomic, strong)NSString *url;

// file actually save path
@property (nonatomic, strong)NSString *targetPath;

// down load queue
@property (nonatomic, strong)NSOperationQueue *queue;

@property (nonatomic, strong)NSOutputStream *stream;

@property (nonatomic, assign)BOOL isDownloading;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@property (nonatomic, strong)NSString *directory;

@property (nonatomic, strong)NSString *suggestedFilename;

@end

@implementation YXDownLoad

// save per data then combine


- (instancetype)init{
    self = [super init];
    if (self) {
//        self.perDownloadLength = 1024*1024*50;
                self.perDownloadLength = 860488136;
        //        self.perDownloadLength = 1024*1024*50;

//        self.expectedContentLength = 860488135;
        self.targetPath = [NSHomeDirectory() stringByAppendingString:@"/aa"];
        self.queue = [[NSOperationQueue alloc]init];
        self.queue.maxConcurrentOperationCount = 3;
        self.url = @"http://172.20.10.4/wm_5HPMkSU5_wm.mp4";
        self.semaphore = dispatch_semaphore_create(0);
              
        [self fileSize];
        
        @weakify(self)
        
        [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            [weak_self.session getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
                NSLog(@"%d",dataTasks.count);
                if (dataTasks.count == 0) {
                    [timer invalidate];
                    [weak_self combine];
                    
                }
            }];
        } repeats:YES];
        
    }
    return self;
}

// get file size
- (void)fileSize{
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
//    request.HTTPMethod = @"HEAD";
//    @weakify(self);
//    [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [weak_self estimateDownTimes:response.expectedContentLength];
//    }];
    
    [self estimateDownTimes:860488135];
      
}

// create an download task
- (void)download:(int)index{
    
    // create request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    request.timeoutInterval = 5;
    // set range
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-%lld", index*self.perDownloadLength, (index+1)*self.perDownloadLength] forHTTPHeaderField:@"Range"];
    
    // create task
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    
    task.taskDescription = [NSString stringWithFormat:@"%d",index];
    
    // start
    [task resume];
    
}


/// estimate  down times
/// @param expectedContentLength  file totle length
- (void)estimateDownTimes:(long long)expectedContentLength{
    // task is excuting nonccessy estimate
    if (self.isDownloading||self.perDownloadLength>=expectedContentLength) {
        return;
    }
    // length
      NSInteger downTimes = 0;
       
      if (expectedContentLength%self.perDownloadLength == 0) {
          downTimes = expectedContentLength/self.perDownloadLength;
      }else{
          downTimes = expectedContentLength/self.perDownloadLength+1;
      }
         __weak typeof(self)weakself = self;
       
      for (int i = 0;i<= downTimes;i++) {
          @autoreleasepool {
              [self.queue addOperationWithBlock:^{
                  [weakself download:i];
              }];
          }
      }
}

// append data when directory has contains file, otherwise it will be write data to the file in the first time
- (void)appendData:(NSData *)data{
    NSFileHandle *fp = [NSFileHandle fileHandleForWritingAtPath:self.targetPath];
    if (fp) {
        [fp seekToEndOfFile];
        [fp writeData:data];
        [fp closeFile];
    }else{
        [data writeToFile:self.targetPath atomically:YES];
    }
}


- (void)combine{
    
    for (int i = 0; i < 18; i++) {
        @autoreleasepool {
            NSString *path = [self filePath:[NSString stringWithFormat:@"%d",i]];
            [self appendData:[NSData dataWithContentsOfFile:path]];
            
//            [NSFileManager.defaultManager removeItemAtPath:path error:nil];
        }
    }
}


- (NSString *)filePath:(NSString *)index{
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",index,self.suggestedFilename];
    return [self.directory stringByAppendingPathComponent:fileName];
}


// 懒加载 下载任务共享一个session
- (NSURLSession *)session{
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session= [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

- (NSString *)directory{
    if (!_directory) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _directory = [path stringByAppendingPathComponent:self.url.md5String];
              // crate directory
        [NSFileManager.defaultManager createDirectoryAtPath:_directory withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSLog(@"directory: %@",_directory);
    }
    return _directory;
}


#pragma mark - download delegate


/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be discontiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [self.stream write:data.bytes maxLength:data.length];
}


/* The task has received a response and no further messages will be
 * received until the completion block is called. The disposition
 * allows you to cancel a request or to turn a data task into a
 * download task. This delegate message is optional - if you do not
 * implement it, you can get the response as a property of the task.
 *
 * This method will not be called for background upload tasks (which cannot be converted to download tasks).
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                 didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
       
    self.suggestedFilename = dataTask.response.suggestedFilename;
    
    // will write data to file path
    NSOutputStream *stream = [[NSOutputStream alloc]initToFileAtPath:[self filePath:dataTask.taskDescription] append:YES];
    
    [stream open];
    
    self.stream = stream;
        
    self.isDownloading = YES;

    // allow server access
    completionHandler(NSURLSessionResponseAllow);
}

/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{

}

@end
