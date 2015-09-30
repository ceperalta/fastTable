//
//  TareasTVC.h
//  FastTabla
//
//  Created by Carlos Peralta on 28/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TareasTVC : UITableViewController

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
