//
//  CastNotesViewController.m
//  Quantum Leap Info
//
//  Created by Todd Grooms on 3/25/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "CastNotesViewController.h"

@interface CastNotesViewController ()

@property (assign, nonatomic) CGFloat originalScrollViewBottomEdge;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self preferredContentSizeChanged:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
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

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [self setOriginalScrollViewBottomEdge:[_scrollView contentInset].bottom];
    
    CGFloat bottomEdge = keyboardSize.height;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self adjustScrollViewContentInsetWithBottomEdge:bottomEdge withAnimationDuration:duration andCurve:curve];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGFloat bottomEdge = [self originalScrollViewBottomEdge];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self adjustScrollViewContentInsetWithBottomEdge:bottomEdge withAnimationDuration:duration andCurve:curve];
}

- (void)adjustScrollViewContentInsetWithBottomEdge:(CGFloat)bottomEdge withAnimationDuration:(double)duration andCurve:(NSInteger)curve
{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:duration
                          delay:0.f
                        options:curve
                     animations:^{
                         
                         UIScrollView *scrollView = [weakself scrollView];
                         UIEdgeInsets inset = UIEdgeInsetsMake([scrollView contentInset].top, 0, bottomEdge, 0);
                         [scrollView setContentInset:inset];
                         [scrollView setScrollIndicatorInsets:inset];
                         [[weakself view] layoutIfNeeded];
                     } completion:nil];
}

@end
