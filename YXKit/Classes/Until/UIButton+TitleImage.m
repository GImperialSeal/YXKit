//
//  UIButton+TitleImage.m
//  BoqiiPlant
//  按钮的图片和标题横竖摆放
//  Created by 马文涛 on 16/8/5.
//
//

#import "UIButton+TitleImage.h"
#import "NSString+Help.h"

@implementation UIButton (TitleImage)

/**
 *  全能初始化方法(布局标题和按钮上下对齐，或者左右对齐)
 *
 *  @param frame 按钮大小
 *  @param v     v如果大于0说明是竖着排列，v值代表图片和title的间距
 *  @param h     v如果小于0代表横向排列， h值代表图片是title间距
 *  @param title 按钮title，确保计算标题宽高
 *  @param image 按钮图片，确保计算图片宽高
 *  @param font  确保计算标题宽高用
 *
 *  @return UIButton对象
 */
- (instancetype)initWithFrame:(CGRect)frame verticalValue:(CGFloat)v horizontal:(CGFloat)h title:(NSString *)title image:(UIImage*)image font:(UIFont*)font size:(CGSize)urlImgSize imgUrl:(NSString*)url
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize imageSize;
        self.titleLabel.font = font;
        [self setTitle:title forState:UIControlStateNormal];
        if (image) {
            // 本地图片处理
            [self setImage:image forState:UIControlStateNormal];
            imageSize = image.size;
        }
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 调整uibutton和title上下对齐 按钮上下对齐
        CGFloat imgEdgeY = 0;
        CGFloat imgEdgeX = 0;
        
        CGFloat titleEdgeY = 0;
        CGFloat titleEdgeX = 0;
//        CGFloat titleW = title.length * font.pointSize;
        CGFloat titleW = [title calculateSize:frame.size font:font].width;
        if (v > 0) {
            // 竖着排列
            imgEdgeY = (frame.size.height - imageSize.height - v - font.pointSize)/2;
            imgEdgeX = (frame.size.width - imageSize.width)/2;
            self.imageEdgeInsets = UIEdgeInsetsMake(imgEdgeY, imgEdgeX, 0, 0);

            if (frame.size.width <= imageSize.width+titleW) {
                // 按钮宽度小于图片加标题之和（说明图片和title不能横放在顶部）
                // 同时按钮宽度太小这种情况，如果title有英文字母或者数字，则不是非常准确，title不能完全居中
                titleEdgeX = (frame.size.width - titleW)/2 - imageSize.width;
            }else{
                titleEdgeX = (frame.size.width - titleW)/2 - imageSize.width;
            }
            titleEdgeY = self.imageView.frame.origin.y + imageSize.height + v;
            
            self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeY, titleEdgeX, 0, 0);
        }else{
            // 横排
            imgEdgeY = (frame.size.height - imageSize.height)/2;
            imgEdgeX = (frame.size.width - imageSize.width - titleW - h)/2;
            self.imageEdgeInsets = UIEdgeInsetsMake(imgEdgeY, imgEdgeX, 0, 0);

            CGFloat titleH = [title calculateSize:frame.size font:font].height;
            titleEdgeY = (frame.size.height - titleH)/2;
            titleEdgeX = imgEdgeX + h;
            self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeY, titleEdgeX, 0, 0);
        }
    }
    return self;
}

// 本地图片竖着布局
- (instancetype)initWithFrame:(CGRect)frame verticalValue:(CGFloat)v title:(NSString *)title image:(UIImage*)image font:(UIFont*)font
{
    return [self initWithFrame:frame verticalValue:v horizontal:0 title:title image:image font:font size:CGSizeZero imgUrl:nil];
}

// 本地图片横向布局
- (instancetype)initWithFrame:(CGRect)frame horizontal:(CGFloat)h title:(NSString *)title image:(UIImage*)image font:(UIFont*)font
{
    return [self initWithFrame:frame verticalValue:0 horizontal:h title:title image:image font:font size:CGSizeZero imgUrl:nil];
}

// 网络图片竖着布局
- (instancetype)initWithFrame:(CGRect)frame verticalValue:(CGFloat)v imgUrl:(NSString*)url urlImgSize:(CGSize)urlImgSize title:(NSString *)title font:(UIFont*)font
{
    return [self initWithFrame:frame verticalValue:v horizontal:0 title:title image:nil font:font size:urlImgSize imgUrl:url];
}

// 网络图片横向布局
- (instancetype)initWithFrame:(CGRect)frame horizontal:(CGFloat)h imgUrl:(NSString*)url urlImgSize:(CGSize)urlImgSize title:(NSString *)title font:(UIFont*)font
{
    return [self initWithFrame:frame verticalValue:0 horizontal:h title:title image:nil font:font size:urlImgSize imgUrl:url];
}

@end














