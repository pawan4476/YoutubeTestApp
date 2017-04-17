//
//  ViewController.m
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "DetailsViewController.h"
#import "Reachability.h"
#import "ModelClass.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    Reachability *reachability;
    int decideFunctionality;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesArray = [[NSMutableArray alloc]init];
    self.resultsArray = [[NSMutableArray alloc]init];
    self.downloadedImageArray = [[NSMutableArray alloc]init];
    
#pragma mark - Reachability
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if (remoteHostStatus == NotReachable) {
        
        [self alert:@"Network error" :@"Please connect to the internet"];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"video"];
        NSDictionary *jsonDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self parseData:jsonDic];
        decideFunctionality = 0;
        
    }
    else{
        
    [self getSession:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&maxResults=20&channelId=UCCq1xDJMBRF61kiOgU90_kw&key=AIzaSyBRLPDbLkFnmUv13B-Hq9rmf0y7q8HOaVs"];
        decideFunctionality = 1;
        
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)handleNetworkChange: (NSNotification *)notice{
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if (remoteHostStatus == NotReachable) {
       
        [self alert:@"Network error" :@"Please connect to the internet"];
       
    }    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getSession:(NSString *)url{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (data != nil) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if (jsonDic != nil) {
                
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:jsonDic];
            [userDefaults setObject:data forKey:@"video"];
                
            }
            
            [self parseData:jsonDic];
            
            for (int i = 0; i < self.resultsArray.count; i++) {
                
                ModelClass *model = [self.resultsArray objectAtIndex:i];
            NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageString]];
                [self.downloadedImageArray addObject:data1];
                
            }
            if (self.downloadedImageArray != nil) {
                
            [userDefaults setObject:self.downloadedImageArray forKey:@"imageData"];
                
            }
            [userDefaults synchronize];
            
        }
        else{
            
            [self alert:@"Data not found" :@"Please try again after some time"];
            
        }
    }];
    [dataTask resume];
    
}

-(void)parseData:(NSDictionary *)dict{
    
    id items = [dict valueForKey:@"items"];
    if ([items isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dictionary in items) {
            
            ModelClass *model = [[ModelClass alloc]initWithDict:dictionary];
            [self.resultsArray addObject:model];
            
        }
    }
    else if ([items isKindOfClass:[NSDictionary class]]){
        
    ModelClass *model = [[ModelClass alloc]initWithDict:items];
        [self.resultsArray addObject:model];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.myTableView reloadData];
        
    });
    
}

#pragma mark - TableViewDataSource and TableViewDelegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.resultsArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ModelClass *model = [self.resultsArray objectAtIndex:indexPath.row];
        static NSString *cellIdentifier = @"cell";
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.titleLabel.text = model.titleString;
        cell.descriptionLbel.text = model.descriptionString;
        cell.timeLabel.text = [NSString stringWithFormat:@"Published %@", model.timeString];
    if (decideFunctionality == 0) {
        
        self.imagesArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"imageData"];
        cell.videoImage.image = [UIImage imageWithData:[self.imagesArray objectAtIndex:indexPath.row]];
        
    }
    else if(decideFunctionality == 1){
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageString]];
        cell.videoImage.image = [UIImage imageWithData:data];
    }
        return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"details" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"details"]) {
        
        NSIndexPath *path = [self.myTableView indexPathForSelectedRow];
        ModelClass *model = [self.resultsArray objectAtIndex:path.row];
        DetailsViewController *vc = [segue destinationViewController];
        vc.descriptionString = model.descriptionString;
        vc.videoIdString = model.videoIdString;
        if (decideFunctionality == 0) {
            
            vc.imageData = [self.imagesArray objectAtIndex:path.row];
            vc.decideFunctionality = 0;
        }
        else if (decideFunctionality == 1){
            
            vc.imageString = model.imageString;
            vc.decideFunctionality = 1;
            
        }
        
    }
}

-(void)alert:(NSString *)title :(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
