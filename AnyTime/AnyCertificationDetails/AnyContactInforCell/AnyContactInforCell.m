//
//  AnyContactInforCell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyContactInforCell.h"

@implementation AnyContactInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self.relationshipButton setTitle:@"" forState:(UIControlStateNormal)];
    [self.contactButton setTitle:@"" forState:(UIControlStateNormal)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)contactTouchClick:(id)sender {
    if (self.contactHandler) {
        self.contactHandler();
    }
}
- (IBAction)relationshipTouchClick:(id)sender {
    if (self.relationHandler) {
        self.relationHandler();
    }
}

@end
