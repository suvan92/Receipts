//
//  ReceiptCell.m
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ReceiptCell.h"

@interface ReceiptCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end


@implementation ReceiptCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithReceipt:(Receipt *)recepit {
    self.descriptionLabel.text = recepit.note;
    float floatAmount = [recepit.amount floatValue];
    self.amountLabel.text = [NSString stringWithFormat:@"$%.2f", floatAmount];
}

@end
