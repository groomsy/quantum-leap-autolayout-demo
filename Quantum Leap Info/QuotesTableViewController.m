//
//  QuotesTableViewController.m
//  Quantum Leap Info
//
//  Created by Todd Grooms on 3/25/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "QuotesTableViewController.h"

#import "QuoteTableViewCell.h"
#import "QuotesDataSource.h"

@interface QuotesTableViewController ()

@property (nonatomic, strong) QuoteTableViewCell *prototypeCell;

@end

@implementation QuotesTableViewController

- (QuoteTableViewCell *)prototypeCell
{
    if ( _prototypeCell == nil )
    {
        [self setPrototypeCell:[[self tableView] dequeueReusableCellWithIdentifier:NSStringFromClass([QuoteTableViewCell class])]];
    }
    return _prototypeCell;
}

#pragma mark - View Lifecycle Methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];

    [self preferredContentSizeChanged:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuoteTableViewCell *prototypeCell = [self prototypeCell];
    [(QuotesDataSource *)[[self tableView] dataSource] configureCell:prototypeCell forRowAtIndexPath:indexPath];
    [prototypeCell layoutIfNeeded];

    CGSize size = [[prototypeCell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

#pragma mark NSNotificationCenter Observer Methods
- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    [[self tableView] reloadData];
}

@end
