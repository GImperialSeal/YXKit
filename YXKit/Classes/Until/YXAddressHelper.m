//
//  ZWAddressApi.m
//  zw_app
//
//  Created by 顾玉玺 on 2019/5/13.
//  Copyright © 2019年 中维科技. All rights reserved.
//

#import "YXAddressHelper.h"
#import "NSString+Help.h"
@import AddressBook;
@import Contacts;
@import UIKit;
@implementation YXAddressHelper

#pragma mark - 获取按A~Z顺序排列的所有联系人
+ (void)sort:(NSArray<YXAddressHelperProtocol> *)arr completion:(void(^)(NSMutableDictionary *dict,NSArray *keys,NSArray *oldDatas))complete{
    
    // 将耗时操作放到子线程
    dispatch_queue_t queue = dispatch_queue_create("addressBook.infoDict", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        NSMutableDictionary *addressBookDict = [NSMutableDictionary dictionary];
        
        for (id<YXAddressHelperProtocol>model in arr) {
            //获取到姓名的大写首字母
            NSString *name = model.addressName;
            model.addressNameNamePY = [YXAddressHelper transformPY:name];
            model.addressFirstLetter = [YXAddressHelper getFirstLetter:model.addressNameNamePY];
            
            NSString *firstLetterString = model.addressFirstLetter;
            
//            NSLog(@"firstLet: %@",firstLetterString);
            //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
            if (addressBookDict[firstLetterString]){
                [addressBookDict[firstLetterString] addObject:model];
            }else{
                //创建新发可变数组存储该首字母对应的联系人模型
                NSMutableArray *arrGroupNames = [NSMutableArray arrayWithObject:model];
                //将首字母-姓名数组作为key-value加入到字典中
                [addressBookDict setObject:arrGroupNames forKey:firstLetterString];
            }
        }
        
        // 将addressBookDict字典中的所有Key值进行排序: A~Z
        NSArray *nameKeys = [[addressBookDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        // 将 "#" 排列在 A~Z 的后面
        if ([nameKeys.firstObject isEqualToString:@"#"]){
            NSMutableArray *mutableNamekeys = [NSMutableArray arrayWithArray:nameKeys];
            [mutableNamekeys insertObject:nameKeys.firstObject atIndex:nameKeys.count];
            [mutableNamekeys removeObjectAtIndex:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                complete ? complete(addressBookDict,mutableNamekeys,arr) : nil;
            });
            return;
        }
        
        // 将排序好的通讯录数据回调到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete(addressBookDict,nameKeys,arr) : nil;
        });
        
    });
    
}

+ (NSString *)transformPY:(NSString *)text{
    NSMutableString *str = [[NSMutableString alloc]initWithString:text];
       // 带声调拼音
       CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
       // 不带声调拼音
       CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
       
       NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
       
       NSMutableString *allString = [NSMutableString new];
       
       // 拼音搜索
       int count = 0;
       for (int i = 0; i<pinyinArray.count; i++) {
           
           for (int i = 0; i<pinyinArray.count; i++) {
               if (i == count) {
                   [allString appendString:@"#"];
               }
               [allString appendFormat:@"%@",pinyinArray[i]];
           }
           
           [allString appendString:@","];
           count++;
       }
       
           NSMutableString *initialString = [NSMutableString new];
              
              // 首字符索索
              for (NSString *str in pinyinArray) {
                  if (str.length) {
                      [initialString appendString:[str substringToIndex:1]];
                  }
              }
           [allString appendFormat:@"%@",initialString];

           
       [allString appendFormat:@"%@",text];
       return allString;
}

+ (NSString *)transformPY:(NSString *)text needSimplePY:(BOOL)need{
    
    NSMutableString *str = [[NSMutableString alloc]initWithString:text];
    // 带声调拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    // 不带声调拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    
    NSMutableString *allString = [NSMutableString new];
    
    // 拼音搜索
    int count = 0;
    for (int i = 0; i<pinyinArray.count; i++) {
        [allString appendFormat:@"%@",pinyinArray[i]];
//        NSLog(@"i: %d   str: %@",i,pinyinArray[i]);
        count++;
    }
    return [allString lowercaseString];
}

// 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)getFirstLetter:(NSString *)str{
    // 截取大写首字母
    NSString *firstString = [[str substringWithRange:NSMakeRange(1, 1)] uppercaseString];
//    NSLog(@"str: %@, first: %@",str,firstString);
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
}
/**
 多音字处理
// */
//+ (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
//{
//    if ([aString hasPrefix:@"长"]) { return @"chang";}
//    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
//    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
//    if ([aString hasPrefix:@"地"]) { return @"di";   }
//    if ([aString hasPrefix:@"重"]) { return @"chong";}
//    return pinyinString;
//}


+ (void)getLocalAddressList:(void(^)(NSArray *list))success{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
       if (status == CNAuthorizationStatusNotDetermined) {
           CNContactStore *store = [[CNContactStore alloc] init];
           [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
               if (error) {
                   //无权限
                   [self showAlertViewAboutNotAuthorAccessContact];
               } else {
                   //有权限
                   success([self openContact]);
               }
           }];
       } else if(status == CNAuthorizationStatusRestricted) {
           //无权限
           [self showAlertViewAboutNotAuthorAccessContact];
       } else if (status == CNAuthorizationStatusDenied) {
           //无权限
           [self showAlertViewAboutNotAuthorAccessContact];
       } else if (status == CNAuthorizationStatusAuthorized) {
           //有权限
           success([self openContact]);
       }else{
           success(nil);
       }
}

+ (NSArray<YXAddressHelperProtocol> *)openContact{
    
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString * firstName = contact.familyName;
        NSString * lastName = contact.givenName;
        //电话
        NSArray * phoneNums = contact.phoneNumbers;
        CNLabeledValue *labelValue = phoneNums.firstObject;
        NSString *phoneValue = [[labelValue.value stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([phoneValue isPhoneNum]) {
            YXAddressModel *model = [[YXAddressModel alloc]init];
                  model.addressName = [NSString stringWithFormat:@"%@%@",firstName,lastName];
                  model.addressMoblie = phoneValue;
                  
                  [array addObject:model];
        }
        
      
    }];
    
    return array;
}

+ (void)showAlertViewAboutNotAuthorAccessContact{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请授权通讯录权限" message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许访问您的通讯录" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}


+ (BOOL)isChineseWithStr:(NSString *)str
{
    for(int i=0; i< [str length];i ++)
    {
        int a = [str characterAtIndex:i];
        
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}
@end



@implementation YXAddressModel

@synthesize addressName,addressMoblie,addressNameNamePY,addressFirstLetter;

@end
