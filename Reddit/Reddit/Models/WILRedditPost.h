//
//  WILRedditPost.h
//  Reddit
//
//  Created by William Moody on 5/22/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WILRedditPost : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy, nullable) NSString *thumbnail;

- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail;

@end

@interface WILRedditPost (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
