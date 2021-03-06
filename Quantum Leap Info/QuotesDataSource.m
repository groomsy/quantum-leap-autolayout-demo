//
//  QuotesDataSource.m
//  Quantum Leap Info
//
//  Created by Todd Grooms on 3/23/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "QuotesDataSource.h"

#import "QuoteTableViewCell.h"

@interface QuotesDataSource ()

@property (nonatomic, strong) NSArray *quotes;

@end

@implementation QuotesDataSource

- (NSArray *)quotes
{
    if ( _quotes == nil )
    {
        NSString *quotesPath = [[NSBundle mainBundle] pathForResource:@"Quotes" ofType:@"plist"];
        NSData *quotesData = [[NSFileManager defaultManager] contentsAtPath:quotesPath];
        
        NSString *errorDescription = nil;
        NSPropertyListFormat format;
        NSArray *quotes = (NSArray *)[NSPropertyListSerialization propertyListFromData:quotesData
                                                                      mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                                format:&format
                                                                      errorDescription:&errorDescription];
        [self setQuotes:quotes];
    }
    return _quotes;
}

- (void)configureCell:(QuoteTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *quoteDictionary = [[self quotes] objectAtIndex:[indexPath row]];

    NSString *speaker = quoteDictionary[@"Speaker"];
    [[cell speakerLabel] setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [[cell speakerLabel] setText:speaker];

    NSString *quote = quoteDictionary[@"Quote"];
    [[cell quoteLabel] setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [[cell quoteLabel] setText:quote];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self quotes] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QuoteTableViewCell class])];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

@end
