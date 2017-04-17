//
//  ModelClass.m
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import "ModelClass.h"

@implementation ModelClass

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.titleString = [NSString stringWithFormat:@"%@", [[dict valueForKey:@"snippet"] valueForKey:@"title"]];
        self.imageString = [NSString stringWithFormat:@"%@", [[[[dict valueForKey:@"snippet"] valueForKey:@"thumbnails"] valueForKey:@"high"] valueForKey:@"url"]];
        self.descriptionString = [NSString stringWithFormat:@"%@", [[dict valueForKey:@"snippet"] valueForKey:@"description"]];
        self.timeString = [NSString stringWithFormat:@"%@", [[dict valueForKey:@"snippet"] valueForKey:@"publishedAt"]];
        self.videoIdString = [NSString stringWithFormat:@"%@", [[dict valueForKey:@"id"] valueForKey:@"videoId"]];
        
    }
    return self;
}

@end
