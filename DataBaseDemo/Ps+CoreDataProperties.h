//
//  Ps+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by zhang on 16/4/6.
//  Copyright © 2016年 Messcat. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Ps.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ps (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *as;
@property (nullable, nonatomic, retain) NSString *no;
@property (nullable, nonatomic, retain) NSManagedObject *pw;

@end

NS_ASSUME_NONNULL_END
