//
//  DemoTableViewCell.h
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewCell.h"

@class DemoListModel;
@interface DemoTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@end


@interface DemoListModel : BaseModel

@property (nonatomic, copy) NSString *title;

@end

