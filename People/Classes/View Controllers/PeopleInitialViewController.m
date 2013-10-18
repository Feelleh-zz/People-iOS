//
//  PeopleInitialViewController.m
//  People
//
//  Created by Bruno Koga on 10/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleInitialViewController.h"
#import "PeopleLoginViewController.h"
#import "PeoplePreferences.h"
#import "PeopleServices.h"

@interface PeopleInitialViewController ()

@end

@implementation PeopleInitialViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString * const kInitialToLoginSegue = @"PeopleInitialToLoginSegue";
static NSString * const kInitialToSearchSegue = @"PeopleInitialToSearchSegue";

- (IBAction)transitionToLogin:(id)sender
{
    NSString *segueIdentifier = kInitialToLoginSegue;
    if ([PeoplePreferences isAutoLoginOn])
    {
        [PeopleServices setUsername:[PeoplePreferences username]
                           password:[PeoplePreferences password]];
        segueIdentifier = kInitialToSearchSegue;
    }
    [self performSegueWithIdentifier:segueIdentifier
                              sender:self];

}

- (IBAction)logout:(id)sender {
    [PeoplePreferences resetUsernameAndPassword];
}


@end
