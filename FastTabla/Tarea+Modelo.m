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
    NSPredicate *p = [NSPredicate predicateWithFormat:@"textoMod3 like [cd] %@",[NSString stringWithFormat:@"*%@*",textoAFiltrar]];
    [f setPredicate:p];
    
    /*
    NSArray *a = [app.managedObjectContext executeFetchRequest:f error:nil];
    NSMutableArray *ma = [a mutableCopy];
    */
    
    return f;
}

+(void)addTaskToBDTaskNNS:(NSString*)taskNNS descriptionNSS:(NSString*)descriptionNSS{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    Tarea *tarea = [NSEntityDescription insertNewObjectForEntityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];
    tarea.textoMod3 = taskNNS;
    tarea.descripcionMod = descriptionNSS;
    [app.managedObjectContext save:nil];
}

+(Tarea*)getTaskFromDBTask:(Tarea*)task{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@",task];
    [fetch setPredicate:predicate];
    
    Tarea *taskInDB = (Tarea*)[[app.managedObjectContext executeFetchRequest:fetch error:nil] objectAtIndex:0];

    return taskInDB;
}

@end
