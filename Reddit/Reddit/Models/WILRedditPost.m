//
//  WILRedditPost.m
//  Reddit
//
//  Created by William Moody on 5/22/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

#import "WILRedditPost.h"

@implementation WILRedditPost

-(instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail {
    self = [super init];
    if (self){
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}

@end

@implementation WILRedditPost (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary{
    
    NSDictionary *data = dictionary[@"data"];
    NSString *title = data[@"title"];
    NSString *thumbnail = data[@"thumbnail"];
    
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end
