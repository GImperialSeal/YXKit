//
//  NSString+Validity.m
//  BoqiiMall
//
//  Created by ysw on 15-3-20.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import "NSString+Help.h"

@implementation NSString (Help)

+ (BOOL)isNullString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]] && string.length > 0) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL) isEmail{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isNumber {
    NSString *integerOrFloatPointRegEx = @"[0-9]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isLegalName {
    NSString *integerOrFloatPointRegEx = @"^\\w+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isLegalPrice {
    NSString *integerOrFloatPointRegEx = @"0|[1-9]+[0-9]*|(0|[1-9]+[0-9]*).[0-9]*[1-9]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)input{
    BOOL flag;
    if (input.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:input];
}


+ (BOOL)isPhoneNum:(NSString *)input{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\\d{8}$"];
    return [phoneTest evaluateWithObject:input];
}
- (BOOL)isPhoneNum {
    //    @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //    @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\\d{8}$"];
    return [phoneTest evaluateWithObject:self];
}
+ (BOOL)isMobileNum:(NSString *)input {
    return [NSString isPhoneNum:input];
}
- (BOOL)isMobileNum {
    return [self isPhoneNum];
}

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

+ (CGSize)sizeWithText:(NSString*)someText
              fontSize:(CGFloat)fontSize
        constraintSize:(CGSize)contraintSize{
    CGSize expectedLabelSize = CGSizeZero;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    expectedLabelSize = [someText boundingRectWithSize:contraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return expectedLabelSize;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (CGSize)sizeWithFont:(NSString*)someText fontSize:(CGFloat)fontSize constraintSize:(CGSize)contraintSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = CGSizeZero;
    
    labelSize = [someText boundingRectWithSize:contraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    
    return CGSizeMake(labelSize.width, labelSize.height);
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

//是否是整数
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//是否是浮点数
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end

