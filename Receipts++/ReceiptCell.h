//
//  ReceiptCell.h
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipts__+CoreDataModel.h"

@interface ReceiptCell : UITableViewCell

-(void)configureCellWithReceipt:(Receipt *)recepit;

@end
