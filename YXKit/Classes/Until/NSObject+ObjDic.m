//
//  NSObject+ObjDic.m
//  MiGuKit
//
//  Created by zhgz on 2018/3/10.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import "NSObject+ObjDic.h"
#import <UIKit/UIKit.h>

@implementation NSObject (ObjDic)

-(NSDictionary *)toDictionary
{
	if ([self isKindOfClass:[NSString class]]) {
		@try {
			NSData *data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
			/** *
			 NSJSONReadingMutableContainers 解析为数组或字典
			 NSJSONReadingMutableLeaves 解析为可变字符
			 NSJSONReadingAllowFragments 解析为除上面两个以外的格式
			 */
			NSError *jsonError;
			NSDictionary *objDictionary = [NSJSONSerialization JSONObjectWithData:data
																		  options:NSJSONReadingMutableContainers
																			error:&jsonError];
			return objDictionary;
			
		}
		@catch (NSException *exception) {
			NSLog(@"error");
			return nil;
		}
	}
	else
		NSLog(@"self is not string");
	return nil;
}

-(NSArray *)toArray
{
	if ([self isKindOfClass:[NSString class]]) {
		@try {
			NSData *data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
			/** *
			 NSJSONReadingMutableContainers 解析为数组或字典
			 NSJSONReadingMutableLeaves 解析为可变字符
			 NSJSONReadingAllowFragments 解析为除上面两个以外的格式
			 */
			NSError *jsonError;
			NSArray *objArray = [NSJSONSerialization JSONObjectWithData:data
																options:NSJSONReadingMutableContainers
																  error:&jsonError];
			return objArray;
			
		}
		@catch (NSException *exception) {
			NSLog(@"error");
			return nil;
		}
	}
	else
		NSLog(@"self is not string");
	return nil;
}

-(NSString *)urlEncodeFullOnce
{
	if ([self isKindOfClass:[NSString class]]) {
		@try {
			NSString *decodedUrl = [self urlDecodeFullOnce];
			while(![decodedUrl isEqualToString:[decodedUrl urlDecodeFullOnce]]) {
				decodedUrl = [decodedUrl urlDecodeFullOnce];
			}
//            if([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
//            {
            if(decodedUrl.length==0){
                decodedUrl = (NSString *)self;
            }
            NSString *encodeUrl = [decodedUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            return encodeUrl;
//            }else{
//                NSString*encodedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)decodedUrl,NULL,(CFStringRef)@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~` ",kCFStringEncodingUTF8));
//                return encodedString;
//            }
		}
		@catch (NSException *exception) {
			NSLog(@"error");
			return nil;
		}
	}
	else
		NSLog(@"self is not string");
	return nil;
}

-(NSString *)urlDecodeFullOnce
{
	if ([self isKindOfClass:[NSString class]]) {
		@try {
			if([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
			{
				NSString *decodedString =  [(NSString *)self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                return decodedString==nil?@"":decodedString;
				
			}else{
				NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)(NSString *)self,CFSTR(""),		CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
                return decodedString==nil?@"":decodedString;
			}
		}
		@catch (NSException *exception) {
			NSLog(@"error");
			return nil;
		}
	}
	else
		NSLog(@"self is not string");
	return nil;
}

//- (id)jsonValueForKeys:(id)key, ... NS_REQUIRES_NIL_TERMINATION {
//    id obj = [self jsonValueForKey:key];
//    if (!obj) {
//        return nil;
//    }
//    va_list args;
//    va_start(args, key);
//    if (key) {
//        id otherKey;
//        while (YES) {
//            otherKey = va_arg(args, id);
//            if(!otherKey) {
//                break;
//            } else {
//                obj = [obj jsonValueForKey:otherKey];
//            }
//        }
//    }
//    va_end(args);
//    return obj;
//}

- (id)jsonValueForKeyPath:(NSString *)keyPath {
    if (keyPath.length == 0) {
        return nil;
    }
    if(![keyPath containsString:@"."]
       &&![keyPath containsString:@"["]
       &&![keyPath containsString:@"]"]
       ){
        return [self jsonValueForKey:keyPath];
    }
    NSArray *keyArr = [self parseKeyPath:keyPath];
    return [self jsonValueForKeys:keyArr];
}

- (NSArray *)parseKeyPath:(NSString *)keyPath {
    NSArray *arr = [keyPath componentsSeparatedByString:@"."];
    NSMutableArray *keyArr = [NSMutableArray array];
    for (NSString *key in arr) {
        if ([key containsString:@"["] && [key containsString:@"]"]) {
            NSArray *arrkey = [key componentsSeparatedByString:@"["];
            for (NSString *key in arrkey) {
                if ([key containsString:@"]"]) {
                    [keyArr addObject:[key componentsSeparatedByString:@"]"].firstObject];
                } else {
                    if (key.length > 0) {
                        [keyArr addObject:key];
                    }
                }
            }
        } else {
            [keyArr addObject:key];
        }
    }
    return keyArr;
}

- (id)jsonValueForKeys:(NSArray *)arr {
    if (arr.count == 0) {
        return nil;
    }
    id value = [self jsonValueForKey:arr.firstObject];
    if (arr.count == 1) {
        return value;
    } else {
        return [value jsonValueForKeys:[arr subarrayWithRange:NSMakeRange(1, arr.count - 1)]];
    }
}

- (id)jsonValueForKey:(NSString *)key {
    if ([self isKindOfClass:NSDictionary.class] && key) {
        return [(NSDictionary *)self objectForKey:key];
    } else if ([self isKindOfClass:NSArray.class] && key) {
        NSInteger index = 0;
        if ([key respondsToSelector:@selector(integerValue)]) {
            index = [key integerValue];
        }
        if ([(NSArray *)self count] > index && index >= 0) {
            return [(NSArray *)self objectAtIndex:index];
        }
        return nil;
    } else {
        return nil;
    }
}

@end
