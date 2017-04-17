//
//  TableViewCell.m
//  YoutubeTest
//
//  Created by Nagam Pawan on 4/15/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.videoImage.layer.borderColor = [[UIColor blackColor]CGColor];
    self.videoImage.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
