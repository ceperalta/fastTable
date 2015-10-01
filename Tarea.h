//
//  Tarea.h
//  FastTabla
//
//  Created by Carlos Peralta on 1/10/15.
//  Copyright (c) 2015 Carlos Peralta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tarea : NSManagedObject

@property (nonatomic, retain) NSString * texto;
@property (nonatomic, retain) NSString * descripcion;

@end
