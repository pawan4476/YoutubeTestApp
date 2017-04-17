//
//  ViewController.h
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray  *imagesArray, *downloadedImageArray, *resultsArray;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;



@end

