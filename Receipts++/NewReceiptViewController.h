//
//  NewReceiptViewController.h
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipts__+CoreDataModel.h"

@interface NewReceiptViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *context;

@end
