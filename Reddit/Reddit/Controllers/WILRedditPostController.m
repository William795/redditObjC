//
//  WILRedditPostController.m
//  Reddit
//
//  Created by William Moody on 5/22/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

#import "WILRedditPostController.h"
#import "WILRedditPost.h"
#import "UIKit/UIKit.h"

static NSString * const baseUrlString = @"http://www.reddit.com/.json";

@implementation WILRedditPostController

+ (instancetype)shared{
    static WILRedditPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [WILRedditPostController new];
    });
    return shared;
}

- (void)fetchPost:(void (^)(BOOL))completion{
    
    NSURL *url = [[NSURL alloc] initWithString:baseUrlString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐There was an error in %s:%@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(false);
            return;
        }
        //checking for data  /  could also write all code inside a if(data) {}
        if (!data){
            NSLog(@"data missing🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐🚐");
            completion(false);
            return;
        }
        //going throught json levels
        
        //top level json
        NSDictionary *topLevelJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        //down to first datadict
        NSDictionary *dataDictionary = topLevelJson[@"data"];
        
        //down to children array
        NSArray<NSDictionary *> *childrenArray = dataDictionary[@"children"];
        
        //making the array
        NSMutableArray<WILRedditPost *> *arrayOfPosts = [NSMutableArray new];
        
        // looping through the array grabbing the information spefcified in WILRedditPost
        for (NSDictionary *currentDictionary in childrenArray) {
            WILRedditPost *post = [[WILRedditPost alloc] initWithDictionary:currentDictionary];
            [arrayOfPosts addObject:post];
        }
        WILRedditPostController.shared.posts = arrayOfPosts;
        completion(true);
    }]resume];
}


- (void)fetchImageFromPost:(WILRedditPost *)post completion:(void (^)(UIImage * _Nullable))completion{
    
    NSURL *url = [NSURL URLWithString:post.thumbnail];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s:%@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (!data) {
            NSLog(@"No data for image");
            completion(nil);
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
        
    }]resume];
    
}

@end
