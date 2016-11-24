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

static NSString * const headerTitle = @"Tags";
static NSString * const tagCellReuseIdentifier = @"tagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTapGesure];
}

- (IBAction)canelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(UIButton *)sender {
    [self createNewReceipt];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return headerTitle;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; //((NSArray *)[self fetchTags]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellReuseIdentifier forIndexPath:indexPath];
//    NSArray *arrayOfTags = [self fetchTags];
    cell.textLabel.text = @"A tag"; //((Tag *)arrayOfTags[indexPath.row]).tagName;
    return cell;
}

#pragma mark - CoreData

-(NSArray *)fetchTags {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSError *error = nil;
    NSArray *arrayOfTags = ((NSArray *)[self.context executeRequest:fetchRequest error:&error]);
    return arrayOfTags;
}

-(void)createNewReceipt {
    Receipt *receipt = [[Receipt alloc] initWithContext:self.context];
    receipt.amount = self.amountTextField.text;
    receipt.note = self.descriptionTextField.text;
    receipt.timeStamp = self.datePicker.date;
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
