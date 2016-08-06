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
@interface ViewController ()<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

@end

@implementation ViewController

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController* tovc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    tovc.view.frame = [transitionContext finalFrameForViewController:tovc];
    
    [[transitionContext containerView] addSubview:tovc.view];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        fromvc.view.alpha = 0;
        tovc.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)aaaa:(id)sender {
    
    testVC* vc = [[testVC alloc]initWithNibName:@"testVC" bundle:nil];
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
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
