//
//  WLBaseModel.h
//  wlive
//
//  Created by Fane on 2020/8/6.
//  Copyright © 2020 wcsz. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface WLBaseResultModel : NSObject

@property (nonatomic, strong) NSString *msg;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSString *seq_id;

@property (nonatomic, strong) id ext;

@end

NS_ASSUME_NONNULL_END
