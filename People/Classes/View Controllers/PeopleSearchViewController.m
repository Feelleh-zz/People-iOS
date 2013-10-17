//
//  PeopleSearchViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchViewController.h"
#import "PeopleServices.h"
#import "PeopleSearchDataSource.h"

@interface PeopleSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) PeopleSearchDataSource *datasource;

@end

@implementation PeopleSearchViewController

static NSString * const kPeopleSearchCellIdentifier = @"kPeopleSearchCellIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupTableView
{
    /*
    TableViewCellConfigureBlock configureCell = ^(PhotoCell *cell, Photo *photo) {
        [cell configureForPhoto:photo];
    };
  */

    self.datasource = [[PeopleSearchDataSource alloc] initWithCellIdentifier:kPeopleSearchCellIdentifier
                                                          configureCellBlock:nil];
    self.resultsTableView.dataSource = self.datasource;

    //    [self.tableView registerNib:[PhotoCell nib] forCellReuseIdentifier:PhotoCellIdentifier];
    [self.resultsTableView registerClass:[UITableViewCell class]
                  forCellReuseIdentifier:kPeopleSearchCellIdentifier];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark TableView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextField resignFirstResponder];
}

#pragma mark - Search

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [PeopleServices colaboradoresForSearchTerm:self.searchTextField.text
                                       success:^(NSArray *colaboradores) {
                                           self.datasource.items = [colaboradores copy];
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [self.resultsTableView reloadData];
                                               NSLog(@"%@",self.datasource.items);
                                           });
                                           
                                       } failure:^(NSError *error) {
                                           //handle error
                                       }];
    [textField resignFirstResponder];
    return YES;
}




static NSString * const kSearchToProfileSegue = @"PeopleSearchToProfileSegue";

@end
