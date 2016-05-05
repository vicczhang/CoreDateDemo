//
//  DataTableViewCell.h
//  CoreDataDemo
//
//  Created by zhang on 16/4/22.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *stuNo;
@end
