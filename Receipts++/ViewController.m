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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, TableViewProtocol>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString * const newReceiptSegueIdentifier = @"newReceiptVC";
static NSString * const cellReuseIdentifier = @"receiptCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arrayOfTags = [self fetchTags];
    Tag *tag = arrayOfTags[0];
    NSSet *setOfReceipts = [tag relationship];
    NSLog(@"Tag name: %@, number of receipts: %ld", tag.tagName, setOfReceipts.count);
    
    [self createTags];
}

- (IBAction)addReceiptButton:(UIButton *)sender {
    [self performSegueWithIdentifier:newReceiptSegueIdentifier sender:self];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *sections = [self fetchTags];
    return sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arrayOfTags = [self fetchTags];
    Tag *tagForSection = arrayOfTags[section];
    NSSet *relationshipsToTag = [tagForSection relationship];
    NSInteger rows = relationshipsToTag.count;
    if (rows > 0) {
        return rows;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    Tag *tag = ((NSArray *)[self fetchTags])[indexPath.section];
    NSSet *receipts = [tag relationship];
    if (receipts.count == 0) {
        return cell;
    } else {
        NSArray *receiptsArray = [receipts allObjects];
        Receipt *receipt = receiptsArray[indexPath.row];
        [cell configureCellWithReceipt:receipt];
        return cell;
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *listOfTags = [self fetchTags];
    Tag *tag = listOfTags[section];
    return tag.tagName;
}

-(void)dataUpdated {
    [self.tableView reloadData];
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
    NSError *error = nil;
    NSAsynchronousFetchResult *result = [self.context executeRequest:fetchRequest error:&error];
    NSArray *arrayOfTags = result.finalResult;
    return arrayOfTags;
}

-(void)createTags {
    
    NSArray *arrayOfTags = [self fetchTags];
    NSLog(@"Number of items: %ld", arrayOfTags.count);
    
    for (Tag *tag in arrayOfTags) {
        NSLog(@"%@", tag.tagName);
    }
    
    if (arrayOfTags.count == 0) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:self.context];
        Tag *personal = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.context];
        personal.tagName = @"Personal";
        
        Tag *family = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.context];
        family.tagName = @"Family";
        
        Tag *business = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.context];
        business.tagName = @"Business";
        
        NSError *error = nil;
        [self.context save:&error];
    }
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:newReceiptSegueIdentifier]) {
        NewReceiptViewController *newReceiptVC = segue.destinationViewController;
        newReceiptVC.context = self.context;
        newReceiptVC.delegate = self;
    }
}

@end
