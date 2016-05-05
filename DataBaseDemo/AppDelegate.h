//
//  AppDelegate.h
//  DataBaseDemo
//
//  Created by zhang on 16/3/31.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;


@end

