//
//  MessageBaseCell.h
//  AppFramework
//
//  Created by cnsunrun on 2017/6/5.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface IMMessageBaseCell : BaseTableViewCell


/**
 *  时间
 */
@property (nonatomic, strong)  UILabel *labelTime;

/**
 *   头像
 */
@property (nonatomic, strong)  UIButton *btnPortrait;

/**
 *  昵称
 */
@property (nonatomic, strong)  UILabel *labelNickname;

/**
 *   消息内容容器
 */
@property (nonatomic, strong)  UIView *viewContent;

/**
 *  消息发送状态
 */
@property (nonatomic, strong)  UIImageView *imageSendStatus;

/**
 *   消息阅读状态
 */
@property (nonatomic, strong)  UILabel *labelReadStatus;

@end
