//
//  SettingKindCell1.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"


@interface SettingModelKind1 : NSObject

//左边图标
@property (copy, nonatomic) NSString *iconUrl;
//左边文字
@property (copy, nonatomic) NSString *leftText;
//点击 cell 触发方法名
@property (copy, nonatomic) NSString *method;
//点击 cell 上控件回调
@property (copy, nonatomic) NSString *cellCallbackMethod;
@end


@interface SettingKindCell1 : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@end

