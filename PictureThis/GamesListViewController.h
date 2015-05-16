//
//  GamesListViewController.h
//  PictureThis
//
//  Created by Jake Saferstein on 4/3/15.
//  Copyright (c) 2015 Jake Saferstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

-(instancetype) initWithGames:(NSMutableArray *)games;

-(void)updateGamesList: (NSMutableArray* )games;

@end
