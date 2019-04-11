//
//  NSObject+PerformSelector.m
//  MiGuKit
//
//  Created by 宋乃银 on 2019/1/3.
//  Copyright © 2019 Migu Video Technology. All rights reserved.
//

#import "NSObject+PerformSelector.h"

/** 设置参数 */
void mgSetArgumentForInvocation(id object, NSUInteger index, NSInvocation *inv) {
#define MG_PULL_AND_SET(type, _selector) \
do { \
if ([object respondsToSelector:@selector(_selector)]) {\
type val = [object _selector]; \
[inv setArgument:&val atIndex:(NSInteger)index]; \
} else {\
NSCAssert(NO, @"参数类型不对");\
}\
} while (0)
    
    const char *argType = [inv.methodSignature getArgumentTypeAtIndex:index];
    // Skip const type qualifier.
    if (argType[0] == 'r') {
        argType++;
    }
    if (strcmp(argType, @encode(id)) == 0 || strcmp(argType, @encode(Class)) == 0 || strcmp(argType, @encode(void (^)(void))) == 0) {
        [inv setArgument:&object atIndex:(NSInteger)index];
    } else if (strcmp(argType, @encode(char)) == 0) {
        MG_PULL_AND_SET(char, charValue);
    } else if (strcmp(argType, @encode(int)) == 0) {
        MG_PULL_AND_SET(int, intValue);
    } else if (strcmp(argType, @encode(short)) == 0) {
        MG_PULL_AND_SET(short, shortValue);
    } else if (strcmp(argType, @encode(long)) == 0) {
        MG_PULL_AND_SET(long, longValue);
    } else if (strcmp(argType, @encode(long long)) == 0) {
        MG_PULL_AND_SET(long long, longLongValue);
    } else if (strcmp(argType, @encode(unsigned char)) == 0) {
        MG_PULL_AND_SET(unsigned char, unsignedCharValue);
    } else if (strcmp(argType, @encode(unsigned int)) == 0) {
        MG_PULL_AND_SET(unsigned int, unsignedIntValue);
    } else if (strcmp(argType, @encode(unsigned short)) == 0) {
        MG_PULL_AND_SET(unsigned short, unsignedShortValue);
    } else if (strcmp(argType, @encode(unsigned long)) == 0) {
        MG_PULL_AND_SET(unsigned long, unsignedLongValue);
    } else if (strcmp(argType, @encode(unsigned long long)) == 0) {
        MG_PULL_AND_SET(unsigned long long, unsignedLongLongValue);
    } else if (strcmp(argType, @encode(float)) == 0) {
        MG_PULL_AND_SET(float, floatValue);
    } else if (strcmp(argType, @encode(double)) == 0) {
        MG_PULL_AND_SET(double, doubleValue);
    } else if (strcmp(argType, @encode(BOOL)) == 0) {
        MG_PULL_AND_SET(BOOL, boolValue);
    } else if (strcmp(argType, @encode(char *)) == 0) {
        const char *cString = [object UTF8String];
        [inv setArgument:&cString atIndex:(NSInteger)index];
        [inv retainArguments];
    } else {
        NSCParameterAssert([object isKindOfClass:NSValue.class]);
        
        NSUInteger valueSize = 0;
        NSGetSizeAndAlignment([object objCType], &valueSize, NULL);
        
        unsigned char valueBytes[valueSize];
        [object getValue:valueBytes];
        
        [inv setArgument:valueBytes atIndex:(NSInteger)index];
    }
}

/** 获取方法返回值 */
id mgGetReturnValue(NSInvocation *invocation){
    const char *returnType = invocation.methodSignature.methodReturnType;
    if (returnType[0] == 'r') {
        returnType++;
    }
#define MG_GETRETURN_VALUE(type) \
do { \
type val = 0; \
[invocation getReturnValue:&val]; \
return @(val); \
} while (0)
    if (strcmp(returnType, @encode(id)) == 0 || strcmp(returnType, @encode(Class)) == 0 || strcmp(returnType, @encode(void (^)(void))) == 0) {
        __autoreleasing id returnObj;
        [invocation getReturnValue:&returnObj];
        return returnObj;
    } else if (strcmp(returnType, @encode(char)) == 0) {
        MG_GETRETURN_VALUE(char);
    } else if (strcmp(returnType, @encode(int)) == 0) {
        MG_GETRETURN_VALUE(int);
    } else if (strcmp(returnType, @encode(short)) == 0) {
        MG_GETRETURN_VALUE(short);
    } else if (strcmp(returnType, @encode(long)) == 0) {
        MG_GETRETURN_VALUE(long);
    } else if (strcmp(returnType, @encode(long long)) == 0) {
        MG_GETRETURN_VALUE(long long);
    } else if (strcmp(returnType, @encode(unsigned char)) == 0) {
        MG_GETRETURN_VALUE(unsigned char);
    } else if (strcmp(returnType, @encode(unsigned int)) == 0) {
        MG_GETRETURN_VALUE(unsigned int);
    } else if (strcmp(returnType, @encode(unsigned short)) == 0) {
        MG_GETRETURN_VALUE(unsigned short);
    } else if (strcmp(returnType, @encode(unsigned long)) == 0) {
        MG_GETRETURN_VALUE(unsigned long);
    } else if (strcmp(returnType, @encode(unsigned long long)) == 0) {
        MG_GETRETURN_VALUE(unsigned long long);
    } else if (strcmp(returnType, @encode(float)) == 0) {
        MG_GETRETURN_VALUE(float);
    } else if (strcmp(returnType, @encode(double)) == 0) {
        MG_GETRETURN_VALUE(double);
    } else if (strcmp(returnType, @encode(BOOL)) == 0) {
        MG_GETRETURN_VALUE(BOOL);
    } else if (strcmp(returnType, @encode(char *)) == 0) {
        MG_GETRETURN_VALUE(const char *);
    } else if (strcmp(returnType, @encode(void)) == 0) {
        return nil;
    } else {
        NSUInteger valueSize = 0;
        NSGetSizeAndAlignment(returnType, &valueSize, NULL);
        unsigned char valueBytes[valueSize];
        [invocation getReturnValue:valueBytes];
        
        return [NSValue valueWithBytes:valueBytes objCType:returnType];
    }
    return nil;
}

id mgPerformSelector(SEL sel, id target, NSDictionary *params) {
    if (!sel || !target) {
        return nil;
    }
    
    if ([target respondsToSelector:sel]) {
        NSMethodSignature *signature = [target methodSignatureForSelector:sel];
        if (signature) {
            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:signature];
            [inv setSelector:sel];
            [inv setTarget:target];
            unsigned long count = signature.numberOfArguments - 2;
            for (int i= 0 ; i < count; i++) {
                id value = params[@(i)];
                if (!value) {
                    NSString *key = nil;
                    if ((key = @(i).stringValue)) {
                        value = params[key];
                    }
                }
                mgSetArgumentForInvocation(value, i + 2, inv);
            }
            [inv invoke];
            return mgGetReturnValue(inv);
        }
    }
    return nil;
}

@implementation NSObject (PerformSelector)

- (id)performSelector:(SEL)sel params:(NSDictionary<NSNumber *,id> *)params {
    return mgPerformSelector(sel, self, params);
}

+ (id)performSelector:(SEL)sel params:(NSDictionary<NSNumber *,id> *)params {
    return mgPerformSelector(sel, self, params);
}

@end
