//
//  NSFileManager+Helper.h
//  AFNetworking
//
//  Created by 顾玉玺 on 2019/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Helper)
/** document URL */
+ (NSURL *)documentsURL;

/** document 路径 */
+ (NSString *)documentsPath;

/** library URL */
+ (NSURL *)libraryURL;

/** library 路径 */
+ (NSString *)libraryPath;

/** cache URL */
+ (NSURL *)cachesURL;

/** cache 路径 */
+ (NSString *)cachesPath;
@end

NS_ASSUME_NONNULL_END
