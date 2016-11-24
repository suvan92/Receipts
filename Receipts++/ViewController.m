//
//  ViewController.m
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString * const newReceiptSegueIdentifier = @"newReceiptVC";
static NSString * const cellReuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addReceiptButton:(UIButton *)sender {
    [self performSegueWithIdentifier:newReceiptSegueIdentifier sender:self];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
