//
//  DetailsViewController.h
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) NSString *descriptionString, *videoIdString, *imageString;
@property (strong, nonatomic) NSData *imageData;
@property (assign) int decideFunctionality;

@property (strong, nonatomic) IBOutlet UIImageView *detailsImageView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
- (IBAction)playVideoButton:(id)sender;

@end
