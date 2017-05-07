//
//  MethodDefine.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#ifndef MethodDefine_h
#define MethodDefine_h

#define FONT(size)  [UIFont systemFontOfSize:size]
#define FONT_NAME(fontName, size) [UIFont fontWithName:fontName size:size]

#define RGBA(red,green,blue,alpha) [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha]
#define RGB(red,green,blue) RGBA(red,green,blue,1)

#define URLString(str)  [NSURL URLWithString:str]

#endif /* MethodDefine_h */

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif
