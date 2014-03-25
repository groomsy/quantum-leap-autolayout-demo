//
//  CastNotesViewController.m
//  Quantum Leap Info
//
//  Created by Todd Grooms on 3/25/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "CastNotesViewController.h"

@interface CastNotesViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *beckettLabel;
@property (weak, nonatomic) IBOutlet UITextField *beckettTextField;

@property (weak, nonatomic) IBOutlet UILabel *calavicciLabel;
@property (weak, nonatomic) IBOutlet UITextField *calavicciTextField;

@property (weak, nonatomic) IBOutlet UILabel *ziggyLabel;
@property (weak, nonatomic) IBOutlet UITextField *ziggyTextField;

@end

@implementation CastNotesViewController

#pragma mark - View Lifecycle Methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];

    [self preferredContentSizeChanged:nil];
}

#pragma mark - IBAction Methods
- (IBAction)dismissKeyboard:(id)sender
{
    [_beckettTextField resignFirstResponder];
    [_calavicciTextField resignFirstResponder];
    [_ziggyTextField resignFirstResponder];
}

#pragma mark NSNotificationCenter Observer Methods
- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    [_titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_descriptionLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_beckettLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_calavicciLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_ziggyLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
}

@end
