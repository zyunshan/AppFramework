//
//  BaseTableViewCell.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (weak, nonatomic) id model;

-(void)updateCellWithModel:(id)model;

+(CGFloat)rowHeight;
@end
