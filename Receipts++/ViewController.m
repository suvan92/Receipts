//
//  ViewController.m
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ViewController.h"
#import "NewReceiptViewController.h"
#import "ReceiptCell.h"

@class Tag;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString * const newReceiptSegueIdentifier = @"newReceiptVC";
static NSString * const cellReuseIdentifier = @"receiptCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTags];
}

- (IBAction)addReceiptButton:(UIButton *)sender {
    [self performSegueWithIdentifier:newReceiptSegueIdentifier sender:self];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ((NSArray *)[self fetchTags]).count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; //((NSArray *)[self fetchReceipts]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Hello";
}

#pragma mark - Core Data

-(NSArray *)fetchReceipts {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    NSError *error = nil;
    NSArray *arrayOfReceipts = ((NSArray *)[self.context executeRequest:fetchRequest error:&error]);
    return arrayOfReceipts;
}

-(NSArray *)fetchTags {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
  
    
    
    //NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
    
    NSError *error = nil;
    NSArray *arrayOfTags = ((NSArray<Tag *> *)[self.context executeRequest:fetchRequest error:&error]);
    return arrayOfTags;
    
}

-(void)createTags {
    
    NSArray *arrayOfTags = [self fetchTags];
    
    if (!arrayOfTags) {
        Tag *personal = [[Tag alloc] initWithContext:self.context];
        personal.tagName = @"Personal";
        Tag *family = [[Tag alloc] initWithContext:self.context];
        family.tagName = @"Family";
        Tag *business = [[Tag alloc] initWithContext:self.context];
        business.tagName = @"Business";
    }
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:newReceiptSegueIdentifier]) {
        NewReceiptViewController *newReceiptVC = segue.destinationViewController;
        newReceiptVC.context = self.context;
    }
}

@end
