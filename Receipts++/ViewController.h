//
//  ViewController.h
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipts__+CoreDataModel.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

