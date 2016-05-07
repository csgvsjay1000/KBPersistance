//
//  ViewController.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"

#import "TestInsertData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSError *error = nil;
    
    TestTable *table = [[TestTable alloc] init];
    TestRecord *record = [[TestRecord alloc] init];
    record.age = @(1);
    record.name = @"1";
    record.tomas = @"1";
    [table insertRecord:record error:&error];
    if ([record.primaryKey integerValue] > 0) {
        NSLog(@"1001 success");
    } else {
        NSException *exception = [[NSException alloc] init];
        @throw exception;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
