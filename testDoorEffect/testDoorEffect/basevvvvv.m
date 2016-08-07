//
//  basevvvvv.m
//  testDoorEffect
//
//  Created by zzl on 16/8/7.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import "basevvvvv.h"
#import "UIView+DoorEffect.h"

@interface basevvvvv ()<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

@end

@implementation basevvvvv

{
    BOOL _bpop;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;

}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* tovc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    tovc.view.frame = [transitionContext finalFrameForViewController:tovc];
    UIView* containerView = [transitionContext containerView];

    if( _bpop )
    {
        [containerView insertSubview:tovc.view belowSubview:fromvc.view];
        [tovc.view closeEffect:0.0f block:^(BOOL bleft, BOOL bfinish) {
           
            if( bleft )
            {
                [fromvc.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }
            
        }];
    }
    else
    {
        [containerView addSubview:tovc.view];
        
        [fromvc.view openEffetct:0.0f aboveview:tovc.view
                           block:^(BOOL bleft, BOOL bfinish) {
                               
                               if( bleft )
                               {
                                   [fromvc.view removeFromSuperview];
                                   [transitionContext completeTransition:YES];
                               }
                           }];
        
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    if (operation == UINavigationControllerOperationPush) {
        return self;
    }
    else if (operation == UINavigationControllerOperationPop) {
        _bpop = YES;
        return self;
    }
    return self;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
