//
//  GamesListViewController.m
//  PictureThis
//
//  Created by Jake Saferstein on 4/3/15.
//  Copyright (c) 2015 Jake Saferstein. All rights reserved.
//

#import "GamesListViewController.h"

@interface GamesListViewController ()

@property (nonatomic) UITableView* tableView;
@property (nonatomic) NSMutableArray* gamesList;
@property (nonatomic) BOOL doneLoggingIn;


@end

@implementation GamesListViewController

-(instancetype) init {
    if(self = [super init]) {
        
        
        if([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) /* If logged in */ {
            
            UIImageView* fb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebookLoading.png"]];
            fb.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 150, 100, 100);
            [self.view addSubview:fb];
            
            UIActivityIndicatorView* test = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            test.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 50, 100, 100);
            test.color = [UIColor blackColor];
            [self.view addSubview:test];
            [test startAnimating];
            
            [[SAFParseHelper sharedInstance] loginWithBlock:^(NSMutableArray *friendArrs) {
                //Move on
                if(_doneLoggingIn)
                {
                    [self.tableView reloadData];
                    return;
                }
                
//                [self showTableViewWithArrs:friendArrs];
                _doneLoggingIn = YES;
            }];
            
            
        }
        else /* Set up the login screen */
        {
            UIImageView* fb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebookLoading.png"]];
            fb.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 150, 100, 100);
            [self.view addSubview:fb];
            
            
            UIButton* login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            login.frame = CGRectMake(self.view.frame.size.width/4, fb.frame.origin.y + fb.frame.size.height + 20, self.view.frame.size.width/2, 50);
            login.backgroundColor = [UIColor whiteColor];
            login.layer.cornerRadius = 10;
            [login setTitle:@"Connect to Facebook" forState:UIControlStateNormal];
            
            [self.view addSubview:login];
            [login addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    return self;
}

-(void)loginPressed
{
    
}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//}


@end
