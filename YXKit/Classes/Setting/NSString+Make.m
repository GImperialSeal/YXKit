//
//  NSString+Make.m
//  AFNetworking
//
//  Created by 顾玉玺 on 2019/9/17.
//

#import "NSString+Make.h"
#import <YYKit.h>
@implementation NSString (Make)


- (NSAttributedString *)attributed:(CGFloat)font foregroundColor:(UIColor *)foregroundColor{
    
    return [[NSAttributedString alloc] initWithString:self
                                           attributes:
  @{
    NSFontAttributeName:[UIFont systemFontOfSize:font],
    NSForegroundColorAttributeName:foregroundColor
    }
            ];
}




@end
