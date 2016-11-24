//
//  ViewController.m
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ViewController.h"
#import "NewReceiptViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString * const newReceiptSegueIdentifier = @"newReceiptVC";
static NSString * const cellReuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)addReceiptButton:(UIButton *)sender {
    [self performSegueWithIdentifier:newReceiptSegueIdentifier sender:self];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)[self fetchReceipts]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell withReceipt:(Receipt *)receipt {
    
}

#pragma mark - Fetch Requests

-(NSArray *)fetchReceipts {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    NSError *error = nil;
    NSArray *arrayOfReceipts = ((NSArray *)[self.context executeRequest:fetchRequest error:&error]);
    return arrayOfReceipts;
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:newReceiptSegueIdentifier]) {
        NewReceiptViewController *newReceiptVC = segue.destinationViewController;
        newReceiptVC.context = self.context;
    }
}

@end
