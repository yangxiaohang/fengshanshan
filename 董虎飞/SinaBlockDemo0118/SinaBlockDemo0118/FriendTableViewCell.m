//
//  FriendTableViewCell.m
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_touxiang release];
    [_nameLabel release];
    [_contentLabel release];
    [_sourceLabel release];
    [super dealloc];
}
@end
