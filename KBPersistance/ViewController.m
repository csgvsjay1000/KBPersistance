//
//  ViewController.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"

#import "TestInsertData.h"
#import "TestDataCenter.h"

@interface ViewController ()

@property(nonatomic,strong)TestDataCenter *dataCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestRecord *record = [[TestRecord alloc] init];
    record.age = @(1);
    record.name = @"1";
    record.tomas = @"1";
   
    if ([self.dataCenter saveRecord:record] > 0) {
        NSLog(@"添加成功");
    } else {
        NSLog(@"添加失败");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setters and getters
-(TestDataCenter *)dataCenter{
    if (_dataCenter == nil) {
        _dataCenter = [[TestDataCenter alloc] init];
    }
    return _dataCenter;
}

@end
