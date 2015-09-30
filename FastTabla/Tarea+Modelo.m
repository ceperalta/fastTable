//
//  Tarea+Modelo.m
//  FastTabla
//
//  Created by Carlos Peralta on 29/9/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "Tarea+Modelo.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation Tarea (Modelo)

+(NSFetchRequest*)filtrar_texto:(NSString*)textoAFiltrar{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *f = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *e = [NSEntityDescription entityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];
    [f setEntity:e];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"texto like [cd] %@",[NSString stringWithFormat:@"*%@*",textoAFiltrar]];
    [f setPredicate:p];
    
    /*
    NSArray *a = [app.managedObjectContext executeFetchRequest:f error:nil];
    NSMutableArray *ma = [a mutableCopy];
    */
    
    return f;
}

@end
