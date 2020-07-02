//
//  ZWPutTextBaseController.m
//  zw_app
//
//  Created by apple on 2019/9/23.
//  Copyright © 2019年 中维科技. All rights reserved.
//

#import "ZWPutTextBaseController.h"
#import "ZWPlaceholderTextView.h"
#import "AppDelegate.h"

#import <ReactiveObjC.h>
#import <Masonry.h>

static const CGFloat btnH = 28;
static const CGFloat btnW = 56;

@interface ZWPutTextBaseController ()
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) ZWPlaceholderTextView *contentTF;
@end

@implementation ZWPutTextBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.45];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    
    [self.view addSubview:view];
    [view addSubview:self.cancelBtn];
    [view addSubview:self.sureBtn];
    [view addSubview:self.titleLab];
    [view addSubview:line];
    [view addSubview:self.contentTF];
    
    __weak typeof(self) weakself = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(weakself.view.height*2/5);
    }];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(17);
        make.top.equalTo(view.mas_top).offset(10);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(btnH);
    }];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.cancelBtn.mas_top);
        make.right.equalTo(view.mas_right).offset(-17);
        make.height.mas_equalTo(btnH);
        make.width.mas_equalTo(btnW);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.cancelBtn.mas_top);
        make.bottom.equalTo(weakself.cancelBtn.mas_bottom);
        make.right.equalTo(weakself.sureBtn.mas_left).inset(15);
        make.left.equalTo(weakself.cancelBtn.mas_right).offset(15);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.cancelBtn.mas_bottom).offset(10);
        make.left.right.equalTo(view);
        make.height.equalTo(@0.5);
    }];
    [_contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(15);
        make.bottom.equalTo(view.mas_bottom);
        make.left.equalTo(weakself.cancelBtn.mas_left);
        make.right.equalTo(weakself.sureBtn.mas_right);
    }];
}

-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#03A9F4"] forState:UIControlStateNormal];
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"#03A9F4"].CGColor;
        _cancelBtn.layer.cornerRadius = 3;
        __weak typeof(self) weakself =self;
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _cancelBtn;
}
-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#03A9F4"] forState:UIControlStateNormal];
        _sureBtn.layer.borderWidth = 1;
        _sureBtn.layer.borderColor = [UIColor colorWithHexString:@"#03A9F4"].CGColor;
        _sureBtn.layer.cornerRadius = 3;
        __weak typeof(self) weakself =self;
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSString *content = weakself.contentTF.text;
            if (content.length==0) {
                ZWTOAST(weakself.placeholder);
                return ;
            }
            !weakself.sureBlock?:weakself.sureBlock(weakself.contentTF.text);
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _sureBtn;
}
-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.attributedText = [self attributedStringWithTextViewContent:self.contentTF.text];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

-(ZWPlaceholderTextView *)contentTF {
    if (!_contentTF) {
        _contentTF = [[ZWPlaceholderTextView alloc] init];
        _contentTF.placeholder = _placeholder;
        _contentTF.maxCount = _maxCount;
        _contentTF.backgroundColor = [UIColor clearColor];
        __weak typeof(self) weakself = self;
        _contentTF.contentDidChanged = ^(NSString * _Nonnull content) {
            weakself.titleLab.attributedText = [weakself attributedStringWithTextViewContent:content];
        };
    }
    return _contentTF;
}

-(NSMutableAttributedString *)attributedStringWithTextViewContent:(NSString *)content {
    if (_maxCount==0) {
        return [NSMutableAttributedString new];
    }
    NSString *before = [NSString stringWithFormat:@"%i/",content.length];
    NSString *after = [NSString stringWithFormat:@"%i",_maxCount];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",before,after]];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#03A9F4"] range:NSMakeRange(0, before.length)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#555555"] range:NSMakeRange(before.length, after.length)];
    return attri;
}

-(void)presentSelfAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    [self presentSelfAnimated:flag modalTransitionStyle:0 completion:completion];
}

-(void)presentSelfAnimated:(BOOL)flag modalTransitionStyle:(PTModalTransitionStyle)style completion:(void (^ __nullable)(void))completion {
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *view = self;
    view.view.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    //在present一个viewController时会需要一个提供背景的viewController，设置definespresentationcontext为true可以把当前的viewController设置为present的背景，present时会从当前容器中找presentationcontext，没有找到就默认为当前容器的rootViewController
    appdelegate.window.rootViewController.definesPresentationContext = YES;
    
    view.modalTransitionStyle   = [self transitionStyle:style];
    view.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [appdelegate.window.rootViewController presentViewController:view animated:YES completion:completion];
}

-(UIModalTransitionStyle)transitionStyle:(PTModalTransitionStyle)style {
    switch (style) {
        case PTModalTransitionStyleCoverVertical:
            return UIModalTransitionStyleCoverVertical;
            break;
        case PTModalTransitionStyleFlipHorizontal:
            return UIModalTransitionStyleFlipHorizontal;
            break;
        case PTModalTransitionStyleCrossDissolve:
            return UIModalTransitionStyleCrossDissolve;
            break;
        case PTModalTransitionStylePartialCurl:
            return UIModalTransitionStylePartialCurl;
            break;
            
        default:
            break;
    }
}

@end
