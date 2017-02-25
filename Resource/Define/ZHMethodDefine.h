//
//  ZHMethodDefine.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#ifndef ZHMethodDefine_h
#define ZHMethodDefine_h

#define FONT(size)  [UIFont systemFontOfSize:size]
#define FONT(fontName, size) [UIFont fontWithName:fontName size:size]

#define RGBA(red,green,blue,alpha) [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha]
#define RGB(red,green,blue) RGBA(red,green,blue,1)

#define URLString(str)  [NSURL URLWithString:str]

#endif /* ZHMethodDefine_h */
