//
//  SAFParseHelper.m
//  SoundBomber
//
//  Created by Jake Saferstein on 4/13/15.
//  Copyright (c) 2015 Jake Saferstein. All rights reserved.
//

#import "SAFParseHelper.h"

@interface SAFParseHelper ()

@end

@implementation SAFParseHelper

SINGLETON_IMPL(SAFParseHelper);

-(id)init
{
    if (self = [super init]) {
    }
    return self;
}

-(void)updateDataWithBlock:(void (^)(NSMutableArray *games)) updateCompletion
{
    [[PFUser currentUser] fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        [JFParseFBFriends findFriendsAndUpdate:YES completion:^(BOOL success, BOOL localStore, NSArray *pfusers, NSError *error) {
            
            [self getGamesFromFriendsList:pfusers withBlock:^(NSMutableArray *games) {
                
                //No need to refresh if no new data
                if(!localStore) {
                    updateCompletion(games);
                }
            }];
        }];
    }];
    
}

- (void)getGamesFromFriendsList:(NSArray*) friends withBlock:(void (^)(NSMutableArray* games))gamesList
{
    
}



-(void) loginWithBlock:(void (^)(NSMutableArray *games)) loginCompletion
{
    /* If logged in */
    if([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
        [JFParseFBFriends findFriendsAndUpdate:YES completion:^(BOOL success, BOOL localStore, NSArray *pfusers, NSError *error) {
            [self getGamesFromFriendsList:pfusers withBlock:^(NSMutableArray *games) {
                loginCompletion(games);
            }];
        }];
        return;
    }
    
    /* Otherwise */
    [PFFacebookUtils logInWithPermissions:@[@"public_profile", @"user_friends"] block:^(PFUser *user, NSError *error) {
        
        //Create Revenge and Recent list if necessary
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            
        } else {
            NSLog(@"User logged in through Facebook!");
            
        }
        
        [JFParseFBFriends updateCurrentUserWithCompletion:^(BOOL success, NSError *error) {
            
            [JFParseFBFriends findFriendsAndUpdate:YES completion:^(BOOL success, BOOL localStore, NSArray *pfusers, NSError *error) {
                
                [self getGamesFromFriendsList:pfusers withBlock:^(NSMutableArray *games) {
                    loginCompletion(games);
                }];
            }];
        }];
    }];
}

@end
