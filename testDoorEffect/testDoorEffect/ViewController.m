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

- (IBAction)mgoto:(id)sender {
    
    [self.view openEffetct:^(BOOL bleft, BOOL bfinish) {
        
        if( bleft )
        {
 
            testVC* vc = [[testVC alloc]initWithNibName:@"testVC" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:NO];
        }
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view closeEffect:^(BOOL bleft, BOOL bfinish) {
        
       
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
