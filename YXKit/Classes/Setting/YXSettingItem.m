//
//  ZFSettingItem.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "YXSettingItem.h"
#import <YYKit.h>
@interface YXSettingItem()


@end

@implementation YXSettingItem

- (YXSettingItem *(^)(EditBlock))setEditBlock{
    return ^YXSettingItem *(EditBlock block) {
        self.editBlock = block;
        return self;
    };
}

- (YXSettingItem *(^)(BOOL))setScrollEnabled{
    return ^YXSettingItem *(BOOL h) {
        self.scrollEnabled = h;
        return self;
    };
}

- (YXSettingItem *(^)(CellBlock))setCellBlock{
    return ^YXSettingItem *(CellBlock block) {
        self.cellBlock = block;
        return self;
    };
}

- (YXSettingItem *(^)(UITableViewCellAccessoryType))setAccessoryType{
    return ^YXSettingItem *(UITableViewCellAccessoryType h) {
        self.accessoryType = h;
        return self;
    };
}

- (YXSettingItem *(^)(BOOL))setHideSeparatorLine{
    return ^YXSettingItem *(BOOL h) {
        self.hideSeparatorLine = h;
        return self;
    };
}
- (YXSettingItem *(^)(NSString *))setUrl{
    return ^YXSettingItem *(NSString *url) {
        self.url = url;
        return self;
    };
}

- (YXSettingItem *(^)(CGFloat))setRowHeight{
    return ^YXSettingItem *(CGFloat h) {
        self.rowHeight = h;
        return self;
    };
}

- (YXSettingItem *(^)(NSAttributedString *))setTitle{
    return ^YXSettingItem *(NSAttributedString *title) {
        self.title = title;
        return self;
    };
}

- (YXSettingItem *(^)(NSAttributedString *))setSubtitle{
    return  ^YXSettingItem *(NSAttributedString *subtitle) {
        self.subtitle = subtitle;
        return self;
    };
}

- (YXSettingItem *(^)(NSString *))setPlaceholder{
    return ^YXSettingItem *(NSString *palce) {
        self.placeholder = palce;
        return self;
    };
}

- (YXSettingItem *(^)(UIKeyboardType))setKeyType{
    return ^YXSettingItem *(NSInteger type) {
        self.keyType = type;
        return self;
    };
}

- (YXSettingItem *(^)(NSInteger))setLimitEdit{
    return ^YXSettingItem *(NSInteger type) {
        self.limitEditLength = type;
        return self;
    };
}


- (YXSettingItem *(^)(NSString *))setText{
    return ^YXSettingItem *(NSString *text) {
        self.text = text;
        return self;
    };
}

+ (instancetype)itemTypeDefault:(NSString *)icon{
    YXSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.style = YXTableViewCellStyleDefault;
    return item;
}

+ (instancetype)itemTypeValue1{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleValue1;
    return item;
}
+ (instancetype)itemTypeValue4{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleValue4;
    return item;
}


+ (instancetype)itemTypeValue3{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleValue3;
    return item;
}

+ (instancetype)itemTypeValue3Center{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleValue3_fit;
    return item;
}

+ (instancetype)itemTypeSlider{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleSlider;
    return item;
}

+ (instancetype)itemTypeInput{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleInput;
    return item;
}

+ (instancetype)itemTypeNineBox{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleNineBox;
    return item;
}
+ (instancetype)itemTypePicker{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStylePicker;
    item.hideHint = NO;
    item.maxImageCount = 6;
    return item;
}

+ (instancetype)itemTypeSelected{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleSelected;
    return item;
}

+ (instancetype)itemTypeTextField{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleTextField;
    item.isObserveSubtitle = YES;
    return item;
}

+ (instancetype)itemTypeTextView{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleTextView;
    return item;
}

+ (instancetype)itemTypeCustom{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleCustom;
    return item;
}

+ (instancetype)itemTypeSubtitle{
    YXSettingItem *item = [[self alloc] init];
    item.style = YXTableViewCellStyleSubtitle;
    return item;
}

- (void)setStyle:(YXTableViewCellStyle)style{
    _style = style;
    switch (style) {
        case YXTableViewCellStyleDefault:
            self.reuseIdentifier = @"YXTableViewCellStyleDefault";
        break;
        case YXTableViewCellStyleValue1:
            self.reuseIdentifier = @"YXTableViewCellStyleValue1";
        break;
        case YXTableViewCellStyleValue2:
            self.reuseIdentifier = @"YXTableViewCellStyleValue2";
        break;
        case YXTableViewCellStyleValue3:
            self.reuseIdentifier = @"YXTableViewCellStyleValue3";
        break;
        case YXTableViewCellStyleValue4:
            self.reuseIdentifier = @"YXTableViewCellStyleValue4";
        break;
        case YXTableViewCellStyleSubtitle:
            self.reuseIdentifier = @"YXTableViewCellStyleSubtitle";
        break;
        case YXTableViewCellStyleNineBox:
            self.reuseIdentifier = @"YXTableViewCellStyleNineBox";
        break;
        case YXTableViewCellStyleInput:
            self.reuseIdentifier = @"YXTableViewCellStyleInput";
        break;
        case YXTableViewCellStyleTextView:
            self.reuseIdentifier = @"YXTableViewCellStyleTextView";
        break;
        case YXTableViewCellStyleTextField:
            self.reuseIdentifier = @"YXTableViewCellStyleTextField";
        break;
        case YXTableViewCellStyleCustom:
            self.reuseIdentifier = @"YXTableViewCellStyleCustom";
        break;
        default:
            self.reuseIdentifier = @"YXTableViewCellStyleDefault";
            break;
    }
}

- (instancetype)init{
    if ([super init]) {
        self.rowHeight = UITableViewAutomaticDimension;
        self.limitEditLength = 500;
        self.accessoryview = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.hideSeparatorLine = NO;
    }
    return self;
}


- (NSAttributedString *)combineAttributeString:(NSString *)title subtitle:(NSString *)subtitle{
    if (!subtitle.length) { subtitle = @"暂无"; }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:subtitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#888888"]}];
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"]}];
    [att insertAttributedString:attr atIndex:0];
    return att;
}
// 浅灰色
- (NSAttributedString *)defaultSubtitle:(NSString *)text font:(CGFloat)font{
    if (!text.length) { text = @"暂无"; }
    
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#888888"]}];
}

- (NSAttributedString *)defaultSubtitle:(NSString *)text color:(UIColor *)color{
    if (!text.length) { text = @"暂无"; }
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:color}];
}

// 深黑色
- (NSAttributedString *)defaultDarkTitle:(NSString *)text{
    if (!text.length) { return nil; }
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#212121"]}];
}

// 黑色
- (NSAttributedString *)defaultNormalTitle:(NSString *)text{
    if (!text.length) { return nil; }
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"]}];
}

- (NSAttributedString *)combineAttributeStringWithFstRed:(NSString *)title subtitle:(NSString *)subtitle{
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:subtitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#888888"]}];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:title];
    NSInteger wz = 1;
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, title.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#555555"] range:NSMakeRange(wz, title.length-wz)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, wz)];
    [attr appendAttributedString:att];
    return attr;
}

- (NSAttributedString *)textAttachment:(NSTextAttachment *)attch text:(NSString *)text{
    //    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //    // 表情图片
    //
    //    attch.image = [UIImage imageNamed:@"parking_caveat_normal"];
    //
    //    // 设置图片大小
    //    attch.bounds = CGRectMake(0, 0, 14, 14);
    
    
    NSAttributedString *attchAtt = [NSAttributedString attributedStringWithAttachment:attch];
    
    NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc]init];
    
    style.paragraphSpacing = 10;
    
    style.alignment = NSTextAlignmentCenter;
    
    style.lineSpacing = 10;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",text] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#212121"]}];
    
    [attr insertAttributedString:attchAtt atIndex:0];
    
    [attr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, 1)];
    
    return attr;
}

- (NSAttributedString *)defaultNormalTitleWithFstRed:(NSString *)title{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:title];
    NSInteger wz = 1;
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, title.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#555555"] range:NSMakeRange(wz, title.length-wz)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, wz)];
    return attr;
}

- (NSAttributedString *)defaultDarkTitleWithFstRed:(NSString *)title{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:title];
    NSInteger wz = 1;
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, title.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#212121"] range:NSMakeRange(wz, title.length-wz)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, wz)];
    return attr;
}



@end

