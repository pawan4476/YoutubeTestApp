//
//  ModelClass.h
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelClass : NSObject

@property (strong, nonatomic) NSString *titleString, *imageString, *descriptionString, *timeString, *videoIdString;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
