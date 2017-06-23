//
//  DemoTableViewCell.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)updateCellWithModel:(DemoListModel *)model{
    self.labelTitle.text = model.title;
}
@end


@implementation DemoListModel
@end
