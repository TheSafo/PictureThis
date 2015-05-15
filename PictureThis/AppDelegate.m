//
//  AppDelegate.m
//  PictureThis
//
//  Created by Jake Saferstein on 4/2/15.
//  Copyright (c) 2015 Jake Saferstein. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"
#import "GamesListViewController.h"
#import <Parse/Parse.h>
#import "SAFTabBarController.h"

@interface AppDelegate ()

@property(nonatomic,strong) UITabBarController* tabCtrlr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [Parse setApplicationId:@"bEnm8kxhKPWBYVXmOviBTwEyJkVRa3BmGFP53kFT"
                  clientKey:@"KsU0HGMCsOeYIB6us17VEQuhMKsrpgGBQs8CxLC9"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    _tabCtrlr = [[SAFTabBarController alloc] init];
    
    UITabBarItem* feedBtn = [[UITabBarItem alloc] initWithTitle:@"Feed" image:[UIImage imageNamed:@"feedIcon"] tag:0];
    UITabBarItem* gamesListBtn = [[UITabBarItem alloc] initWithTitle:@"Games" image:[UIImage imageNamed:@"gamesListIcon"] tag:1];

    FeedViewController* feedCtlr = [[FeedViewController alloc] init];
    feedCtlr.title = @"Winners' Feed";
//    feedCtlr.tabBarItem = feedBtn;
    
    
    GamesListViewController* gamesListCtrlr = [[GamesListViewController alloc] init];
    gamesListCtrlr.title = @"Available Games";
//    gamesListCtrlr.tabBarItem = gamesListBtn;
    
    UINavigationController* leftCtrlr = [[UINavigationController alloc] initWithRootViewController:feedCtlr];
    leftCtrlr.tabBarItem = feedBtn;
    leftCtrlr.navigationBar.barTintColor = [UIColor greenColor];
    UINavigationController* rightCtrlr = [[UINavigationController alloc] initWithRootViewController:gamesListCtrlr];
    rightCtrlr.tabBarItem = gamesListBtn;
    rightCtrlr.navigationBar.barTintColor = [UIColor greenColor];
    
    _tabCtrlr.viewControllers = @[leftCtrlr , rightCtrlr];
    
    [self.window setRootViewController:_tabCtrlr];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
