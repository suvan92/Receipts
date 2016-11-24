//
//  NewReceiptViewController.m
//  Receipts++
//
//  Created by Suvan Ramani on 2016-11-24.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "NewReceiptViewController.h"

@interface NewReceiptViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) UITapGestureRecognizer *tapGR;

@end

@implementation NewReceiptViewController

static NSString * const tagCellReuseIdentifier = @"tagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTapGesure];
}

- (IBAction)canelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Gestures

-(void)addTapGesure {
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.tapGR];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
