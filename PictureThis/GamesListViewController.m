//
//  GamesListViewController.m
//  PictureThis
//
//  Created by Jake Saferstein on 4/3/15.
//  Copyright (c) 2015 Jake Saferstein. All rights reserved.
//

#import "GamesListViewController.h"
#import "GameTableViewCell.h"

@interface GamesListViewController ()

@property (nonatomic) NSMutableArray* gamesList;
@property (nonatomic) UITableView* tableView;

@end

@implementation GamesListViewController

-(instancetype) initWithGames:(NSMutableArray *)games {
    if(self = [super init]) {
        
        _gamesList = games;
        
        int w = self.view.frame.size.width;
        int h = self.view.frame.size.height;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, w, h-65) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

    return self;
}

-(void)updateGamesList: (NSMutableArray* )games
{
    _gamesList = games;
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"game"];
    if (!cell) {
        
        cell = [[GameTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"game"];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gamesList.count;
}


@end
