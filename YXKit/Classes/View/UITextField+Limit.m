//
//  UITextField+Limit.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "UITextField+Limit.h"
#import <objc/runtime.h>
@implementation UITextField (Limit)


- (void)enventForTextFieldChanged:(UITextField *)textField{
    if (self.edittingBlock) self.edittingBlock(textField.text);
    
    NSInteger kMaxLength = textField.limitLength;
    
    NSString *toBeString = textField.text;
    
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
                if (self.editedBlock) self.editedBlock(textField.text);
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
            if (self.editedBlock) self.editedBlock(textField.text);
        }
        
    }
}




- (void)setLimitLength:(NSInteger)limitLength{
    [self addTarget:self action:@selector(enventForTextFieldChanged:) forControlEvents:UIControlEventValueChanged];
    objc_setAssociatedObject(self, _cmd, @(limitLength), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setEditedBlock:(EditedBlock)editBlock{
    objc_setAssociatedObject(self, _cmd, editBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEdittingBlock:(EdittingBlock)edittingBlock{
    objc_setAssociatedObject(self, _cmd, edittingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

}


- (EditedBlock)editedBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (EdittingBlock)edittingBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (NSInteger)limitLength{
    NSNumber *limit = objc_getAssociatedObject(self, _cmd);
    return limit.integerValue;
}


@end
