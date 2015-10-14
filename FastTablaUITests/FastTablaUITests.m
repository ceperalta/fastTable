//
//  FastTablaUITests.m
//  FastTablaUITests
//
//  Created by Carlos Peralta on 6/10/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FastTablaUITests : XCTestCase

@end

@implementation FastTablaUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUICreateUpdateDelete {
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.navigationBars[@"Tareas"].buttons[@"Agregar"] tap];
   
    [app.textFields[@"theTitle"] tap];
    [app.textFields[@"theTitle"] typeText:@"comprar pan"];
   
    [app.textFields[@"theDescriptionField"] tap];
    [app.textFields[@"theDescriptionField"] typeText:@"del bueno, árabe!"];
   
    [app.buttons[@"Agregar"] tap];
    
    [[[app.tables childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0] tap];
    
    [app.textFields[@"theTitle"] tap];
    [app.textFields[@"theTitle"] typeText:@" modificado!"];
    
    [app.buttons[@"Editar"] tap];
    
    
    XCUIElement *firstCell = [[app.tables childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0];
    
    [firstCell swipeLeft];
    
    [app.buttons[@"Delete"] tap];
    
}



@end
