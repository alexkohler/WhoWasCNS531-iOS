//
//  TableDisplayCell.m
//  whowasCNS
//
//  Created by Alexander Kohler on 9/11/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "TableDisplayCell.h"

@implementation TableDisplayCell
@synthesize date = _date;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
