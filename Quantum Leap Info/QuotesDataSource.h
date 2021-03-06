//
//  QuotesDataSource.h
//  Quantum Leap Info
//
//  Created by Todd Grooms on 3/23/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuoteTableViewCell;

@interface QuotesDataSource : NSObject <UITableViewDataSource>

- (void)configureCell:(QuoteTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
