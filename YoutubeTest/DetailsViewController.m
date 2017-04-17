//
//  DetailsViewController.m
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.decideFunctionality == 0 ) {
        
        self.detailsImageView.image = [UIImage imageWithData:self.imageData];

    }
    else if (self.decideFunctionality == 1){
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageString]];
        self.detailsImageView.image = [UIImage imageWithData:data];
        
    }
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@", self.descriptionString];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)playVideoButton:(id)sender {
    
    [self openUrl];
    
}

-(void)openUrl{
    
    NSString *urlForApp = [NSString stringWithFormat:@"youtube://%@", self.videoIdString ];
    NSString *urlForWeb = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", self.videoIdString];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlForApp]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlForApp] options:@{} completionHandler:nil];
        
    }
    else{
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlForWeb] options:@{} completionHandler:nil];
        
    }
}
@end
