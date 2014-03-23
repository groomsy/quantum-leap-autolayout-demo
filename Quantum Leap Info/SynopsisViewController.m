//
//  SynopsisViewController.m
//  Quantum Leap Info
//
//  Created by Todd Grooms on 3/23/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "SynopsisViewController.h"

@interface SynopsisViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation SynopsisViewController

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    CGFloat topConstraint = -[[self scrollViewTopConstraint] constant];
    CGFloat bottomConstraint = -[[self scrollViewBottomConstraint] constant];
    [[self scrollView] setContentInset:UIEdgeInsetsMake(topConstraint, 0, bottomConstraint, 0)];
    
    NSString *synopsisPath = [[NSBundle mainBundle] pathForResource:@"Synopsis" ofType:@"txt"];
    
    NSError *error = nil;
    NSString *synopsis = [NSString stringWithContentsOfFile:synopsisPath
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    if ( error )
    {
        NSLog(@"Error reading synopsis: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    else
    {
        [_synopsisLabel setText:synopsis];
    }
}

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
}

#pragma mark NSNotificationCenter Observer Methods
- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    [_titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_synopsisLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
}

@end
