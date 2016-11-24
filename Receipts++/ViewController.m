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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString * const newReceiptSegueIdentifier = @"newReceiptVC";
static NSString * const cellReuseIdentifier = @"receiptCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)addReceiptButton:(UIButton *)sender {
    [self performSegueWithIdentifier:newReceiptSegueIdentifier sender:self];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //((NSArray *)[self fetchTags]).count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; //((NSArray *)[self fetchReceipts]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell withReceipt:(Receipt *)receipt {
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Hello";
}

#pragma mark - Fetch Requests

-(NSArray *)fetchReceipts {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    NSError *error = nil;
    NSArray *arrayOfReceipts = ((NSArray *)[self.context executeRequest:fetchRequest error:&error]);
    return arrayOfReceipts;
}

-(NSArray *)fetchTags {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSError *error = nil;
    NSArray *arrayOfTags = ((NSArray *)[self.context executeRequest:fetchRequest error:&error]);
    return arrayOfTags;
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:newReceiptSegueIdentifier]) {
        NewReceiptViewController *newReceiptVC = segue.destinationViewController;
        newReceiptVC.context = self.context;
    }
}

@end
