//
//  AppDelegate.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "AppDelegate.h"
#import "UpdateManager.h"
#import "DBManager.h"
#import "DBTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [DBManager manager];
    
    [[DBTool tool]createTableWithName:@"person" withItems:@[@"name", @"sex", @"email", @"age", @"level",@"uid"] primaryKey:@"uid"];
   
    [[DBTool tool] insertTable:@"person" withKeyValues:@{@"uid": @100,
                                                         @"name": @"呵呵呵",
                                                         @"email": @"2434783536@qq.com",
                                                         @"age": @27,
                                                         @"level": @"A"}];
    [[DBTool tool] updateTable:@"person" withKeyValues:@{@"name": @"修改后的名字"} forKey:@"uid" andValue:@"100"];
    
    [[DBTool tool] insertTable:@"person" withKeyValues:@{@"uid": @101,
                                                         @"name": @"101yongh",
                                                         @"email": @"2422222@qq.com",
                                                         @"age": @12,
                                                         @"level": @"A"}];
    
    [[DBTool tool] insertTable:@"person" withKeyValues:@{@"uid": @102,
                                                         @"name": @"101yongh",
                                                         @"email": @"2422222@qq.com",
                                                         @"age": @0,
                                                         @"level": @"C"}];
    
    [[DBTool tool] updateTable:@"person" withKeyValues:@{@"email": @"",
                                                         @"age": @0,
                                                         @"level": @"B"} forKey:@"uid" andValue:@"101"];
    
//    [[DBTool tool] deleteTable:@"person" forKey:@"age" andValue:@"0"];
    
    [[DBTool tool] searchTable:@"person" forKeyValues:@{@"age":@0} completionHandle:^(id result) {
        
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
