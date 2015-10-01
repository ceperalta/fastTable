//
//  MiNSEntityMigrationPolicy.m
//  FastTabla
//
//  Created by Carlos Peralta on 1/10/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import "MiNSEntityMigrationPolicy.h"

@implementation MiNSEntityMigrationPolicy


// called once, before the start of the migration
-(BOOL)beginEntityMapping:(NSEntityMapping *)mapping
                  manager:(NSMigrationManager *)manager
                    error:(NSError *__autoreleasing *)error{
    NSLog(@"%s",__FUNCTION__);
    
    // create a dictionary to store State entities
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"Tarea"] = [NSMutableDictionary dictionary];
    
    // give the dictionary to the migration manager
    [manager setUserInfo:userInfo];
    
    return YES;
}

-(BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)sInstance
                                     entityMapping:(NSEntityMapping *)mapping
                                           manager:(NSMigrationManager *)manager
                                             error:(NSError *__autoreleasing *)error
{
    NSLog(@"%s",__FUNCTION__);
    
    NSArray *_properties = [mapping attributeMappings];
    for (NSPropertyMapping *_property in _properties) {
        if ([[_property name] isEqualToString:@"textoMod3"]) {
            NSExpression *_expression = [NSExpression expressionForConstantValue:@"10to1"];
            [_property setValueExpression:_expression];
        }
    }
    
 [super createDestinationInstancesForSourceInstance:sInstance
                                                entityMapping:mapping
                                                      manager:manager
                                                        error:error];
    
    return YES;
}


@end
