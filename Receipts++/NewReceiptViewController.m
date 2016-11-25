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
@property (strong, nonatomic) NSMutableArray *listOfTagsToAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listOfSelectedRows;

@end

@implementation NewReceiptViewController

static NSString * const headerTitle = @"Tags";
static NSString * const tagCellReuseIdentifier = @"tagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTapGesure];
    self.listOfTagsToAdd = [NSMutableArray new];
    self.listOfSelectedRows = [NSMutableArray new];
}

- (IBAction)canelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(UIButton *)sender {
    [self createNewReceipt];
    NSError *error = nil;
    [self.context save:&error];
    [self.delegate dataUpdated];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return headerTitle;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)[self fetchTags]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellReuseIdentifier forIndexPath:indexPath];
    
    if ([self.listOfSelectedRows containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    NSArray *allTags = [self fetchTags];
    cell.textLabel.text = ((Tag *)allTags[indexPath.row]).tagName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arrayOfTags = [self fetchTags];
    Tag *tag = arrayOfTags[indexPath.row];
    [self.listOfTagsToAdd addObject:tag];
    [self.listOfSelectedRows addObject:indexPath];
    [self.tableView reloadData];
}

#pragma mark - CoreData

-(NSArray *)fetchTags {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSError *error = nil;
    NSAsynchronousFetchResult *result = [self.context executeRequest:fetchRequest error:&error];
    NSArray *arrayOfTags = result.finalResult;
    return arrayOfTags;
}

-(void)createNewReceipt {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:self.context];
    Receipt *receipt = [[Receipt alloc] initWithEntity:entity insertIntoManagedObjectContext:self.context];
    receipt.amount = self.amountTextField.text;
    receipt.note = self.descriptionTextField.text;
    receipt.timeStamp = self.datePicker.date;
    [self createRelationships:receipt];
}

-(void)createRelationships:(Receipt *)receipt {
    for (Tag *tag in self.listOfTagsToAdd) {
        [receipt addRelationshipObject:tag];
    }
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
