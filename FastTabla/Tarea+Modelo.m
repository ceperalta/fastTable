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
#import "RESTHttpClient.h"

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
    
    RESTHttpClient *restHttpClient = [RESTHttpClient createRESTHttpClientSingleton];
    [restHttpClient addTask:tarea];
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

+(void)editTaskOnDB:(Tarea*)taskToEdit taskTitle:(NSString*)taskTitle taskDescription:(NSString*)taskDescription{

    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    Tarea *taskToEditFromDB = [self getTaskFromDBTask:taskToEdit];
    taskToEditFromDB.textoMod3 = taskTitle;
    taskToEditFromDB.descripcionMod = taskDescription;
    
    [app.managedObjectContext save:nil];
    
    RESTHttpClient *restHttpClient = [RESTHttpClient createRESTHttpClientSingleton];
    [restHttpClient editTask:taskToEditFromDB];

}

+(NSString*)getIDStringFromNSManagedObjectTask:(Tarea*)task{
    NSURL *urlID = [[task objectID] URIRepresentation];
    NSString *strId = [urlID absoluteString];
    NSString *strID = [[strId lastPathComponent] substringFromIndex:1];
    return strID;
}

@end
