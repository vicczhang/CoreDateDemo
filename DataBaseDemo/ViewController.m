//
//  ViewController.m
//  DataBaseDemo
//
//  Created by zhang on 16/3/31.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

#import "DataTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    sqlite3 *db;
}
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = appDelegate.managedObjectContext;
    
    [self insertData:5];
    NSLog(@"-------------insertData---------");
    [self checkDataBase];
    
    [self updateForName:@"Person0" modifyAge:@(25)];
    NSLog(@"-------------updateData---------");
    [self checkDataBase];
    
    [self deleteDataBaseTable:@"Person"];
    NSLog(@"-------------removeData---------");
    [self checkDataBase];
    
    
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:v];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    //渐变
    layer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor lightGrayColor].CGColor,(id)[UIColor grayColor].CGColor, nil];
    for (CALayer *sublayer in [v.layer sublayers]){
        [sublayer removeFromSuperlayer];
    }
    [v.layer insertSublayer:layer atIndex:0];
    
}

#pragma mark - CoreData

- (void)insertData:(NSInteger)dataCount{
    
    for (NSInteger i = 0; i<dataCount; i++) {
       
        Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
        p.age=@(18+i);
        p.name=[NSString stringWithFormat:@"Person%ld",i];
        p.sex = i%2==0 ? @"男":@"女";

        Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_context];
        stu.stuNo = [NSString stringWithFormat:@"0000%ld",i+1];
        stu.school = i%2==0 ? @"cccc":@"aaaa";
        stu.stuGrade = @"一年级";
        stu.person = p;
    }
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
}

- (void)checkDataBase{
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchObject = [_context executeFetchRequest:fetchRequest error:&error];
    for (Student *stu in fetchObject) {
        NSLog(@"no : %@",stu.stuNo);
        NSLog(@"school : %@",stu.school);
        NSLog(@"grade : %@",stu.stuGrade);
        NSLog(@"name : %@",stu.person.name);
        NSLog(@"age : %@",stu.person.age);
        NSLog(@"sex : %@",stu.person.sex);
    }
}

/*
 详情的修改可以参考官方文档
 https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
 */
- (void)updateForName:(NSString *)name modifyAge:(NSNumber*)age{
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"name like[cd]%@",name];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context]];
    [request setPredicate:predicate];
    
    NSArray *result = [_context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (Person *person in result) {
        person.age = age;
    }
    
    //保存
    if (![_context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
        
        NSLog(@"更新失败");
    }
    //更新成功
}

- (void)deleteDataBaseTable:(NSString *)dataBaseName{
    NSError *error = nil;
    NSEntityDescription *description = [NSEntityDescription entityForName:dataBaseName inManagedObjectContext:_context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];

    NSArray *datas = [_context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [_context deleteObject:obj];
        }
        if (![_context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    cell.name.text = @"asdf";
    cell.sex.text = @"aaa";
    cell.age.text = @"111";
    cell.stuNo.text = @"11111";
    cell.school.text = @"sfgdfg";
    
  
    return cell;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
