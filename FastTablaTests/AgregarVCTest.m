//
//  AgregarVCTest.m
//  FastTabla
//
//  Created by Carlos Peralta on 5/10/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Tarea.h"
#import "Tarea+Modelo.h"
#import "AppDelegate.h"




@interface AgregarVCTest : XCTestCase

@end


@implementation AgregarVCTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testGoodTaskModelAndExtraMethods{
    NSLog(@"%s",__FUNCTION__);
    
    XCTAssertTrue( [Tarea respondsToSelector:@selector(addTaskToBDTaskNNS: descriptionNSS:)],@"The method addTaskToBDTaskNNS: descriptionNSS: is not in the Tarea model extra methods.");
    
    XCTAssertTrue( [Tarea respondsToSelector:@selector(getTaskFromDBTask:)],@"The method getTaskFromDBTask is not in the Tarea model extra methods.");

    // http://stackoverflow.com/questions/9003690/objective-c-respondstoselector-for-dynamic-properties
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSEntityDescription *taskED = [NSEntityDescription entityForName:@"Tarea" inManagedObjectContext:app.managedObjectContext];

    NSDictionary *attributtesByNameD =  [taskED attributesByName];
    
    XCTAssertTrue([attributtesByNameD objectForKey:@"descripcionMod"] != nil,@"The attribute descripcionMod is missing in the DB");
    XCTAssertTrue([attributtesByNameD objectForKey:@"textoMod3"] != nil,@"The attribute textoMod3 is missing in the DB");
}

-(void)testAddNewTaskToDB{
    NSLog(@"%s",__FUNCTION__);
    
    
    NSString *uniqueStringNSS = @"taskFromTestTitleEsUnicocnjkldnjnsnvunriuervsdfiuvr";
    
    [Tarea addTaskToBDTaskNNS:uniqueStringNSS descriptionNSS:@"taskFromTestDescription"];

    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequestFiltrado = [Tarea filtrar_texto:uniqueStringNSS];
    Tarea *resultTask = [[app.managedObjectContext executeFetchRequest:fetchRequestFiltrado error:nil] firstObject];
    
    XCTAssertEqualObjects(uniqueStringNSS, resultTask.textoMod3);
    
    
    [app.managedObjectContext deleteObject:resultTask];
    [app.managedObjectContext save:nil];
    
}




@end
