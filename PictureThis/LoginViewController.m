//
//  FirstTimeViewController.m
//  PictureThis
//
//  Created by Jake Saferstein on 5/15/15.
//  Copyright (c) 2015 Jake Saferstein. All rights reserved.
//

#import "LoginViewController.h"
#import "SAFTabBarController.h"
#import "FeedViewController.h"
#import "GamesListViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(instancetype) init
{
    if(self = [super init]) {
        self.view.backgroundColor = FACEBOOK_BLUE;
        
//        
//        if([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) /* If logged in */ {
//            
//            UIImageView* fb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebookLoading.png"]];
//            fb.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 150, 100, 100);
//            [self.view addSubview:fb];
//            
//            UIActivityIndicatorView* test = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            test.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 50, 100, 100);
//            test.color = [UIColor blackColor];
//            [self.view addSubview:test];
//            [test startAnimating];
//            
//            [[SAFParseHelper sharedInstance] loginWithBlock:^(NSMutableArray *games) {
//                _gamesList = games;
//                if(_doneLoggingIn)
//                {
//                    [self.tableView reloadData];
//                    return;
//                }
//                
////                [self showGames];
//                _doneLoggingIn = YES;
//            }];
//            
//            
//        }
//        else /* Set up the login screen */
//        {
        UIImageView* fb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebookLoading.png"]];
        fb.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 150, 100, 100);
        [self.view addSubview:fb];
        
        
        UIButton* login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        login.frame = CGRectMake(self.view.frame.size.width/4, fb.frame.origin.y + fb.frame.size.height + 20, self.view.frame.size.width/2, 50);
        login.backgroundColor = [UIColor whiteColor];
        login.layer.cornerRadius = 10;
        login.layer.borderWidth = 2;
        [login setTitle:@"Connect to Facebook" forState:UIControlStateNormal];
        [login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.view addSubview:login];
        [login addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
//        }

    }
    return self;
}

-(void)loginPressed
{
    __block BOOL secondTime = NO;
    __block SAFTabBarController* tabCtrlr = [[SAFTabBarController alloc] init];

    
    [[SAFParseHelper sharedInstance] loginWithBlock:^(NSMutableArray *games) {
        
        GamesListViewController* gamesListCtrlr = [[GamesListViewController alloc] initWithGames:games];
        if(!secondTime)
        {
            UITabBarItem* feedBtn = [[UITabBarItem alloc] initWithTitle:@"Feed" image:[UIImage imageNamed:@"feedIcon"] tag:0];
            UITabBarItem* gamesListBtn = [[UITabBarItem alloc] initWithTitle:@"Games" image:[UIImage imageNamed:@"gamesListIcon"] tag:1];
            
            FeedViewController* feedCtlr = [[FeedViewController alloc] init];
            feedCtlr.title = @"Winners' Feed";
            //    feedCtlr.tabBarItem = feedBtn;
            
            
            gamesListCtrlr.title = @"Available Games";
            //    gamesListCtrlr.tabBarItem = gamesListBtn;
            
            UINavigationController* leftCtrlr = [[UINavigationController alloc] initWithRootViewController:feedCtlr];
            leftCtrlr.tabBarItem = feedBtn;
            leftCtrlr.navigationBar.barTintColor = [UIColor greenColor];
            UINavigationController* rightCtrlr = [[UINavigationController alloc] initWithRootViewController:gamesListCtrlr];
            rightCtrlr.tabBarItem = gamesListBtn;
            rightCtrlr.navigationBar.barTintColor = [UIColor greenColor];
            
            tabCtrlr.viewControllers = @[leftCtrlr , rightCtrlr];
            
            [self presentViewController:tabCtrlr animated:YES completion:^{
                NSLog(@"Logged in");
            }];
            secondTime = YES;
        }
        else{
            [gamesListCtrlr updateGamesList:games];
        }
    }];
}





@end
