//
//  Student+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by zhang on 16/4/22.
//  Copyright © 2016年 Messcat. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *school;
@property (nullable, nonatomic, retain) NSString *stuGrade;
@property (nullable, nonatomic, retain) NSString *stuNo;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END
