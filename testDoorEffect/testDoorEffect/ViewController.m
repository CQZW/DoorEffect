//
//  ViewController.m
//  testDoorEffect
//
//  Created by zzl on 16/7/24.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import "ViewController.h"
#import "testVC.h"
#import "UIView+DoorEffect.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)aaaa:(id)sender {
    
    testVC* vc = [[testVC alloc]initWithNibName:@"testVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)mgoto:(id)sender {
    
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view closeEffect:0.0f block:^(BOOL bleft, BOOL bfinish) {
        
       
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
