//
//  WILRedditPostController.h
//  Reddit
//
//  Created by William Moody on 5/22/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WILRedditPost;

NS_ASSUME_NONNULL_BEGIN

@interface WILRedditPostController : NSObject

@property (nonatomic, copy) NSArray<WILRedditPost *> *posts;

+(instancetype) shared;

-(void)fetchPost:(void (^)(BOOL))completion;

-(void)fetchImageFromPost:(WILRedditPost *)post completion:(void (^) (UIImage * _Nullable))completion;


@end

NS_ASSUME_NONNULL_END
