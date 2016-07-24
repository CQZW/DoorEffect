//
//  UIView+DoorEffect.m
//  testDoorEffect
//
//  Created by zzl on 16/7/24.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import "UIView+DoorEffect.h"
#import "objc/runtime.h"

char* g_rigthdoorkey = "rigthdoorkey";
char* g_leftdoorkey = "leftdoorkey";
char* g_backgd = "backgd";
char* g_backimgname = "bgimgname";
char* g_block_open = "blockopen";
char* g_block_close = "blockclose";
char* g_bopened = "bopened";


@implementation UIView (DoorEffect)

-(NSString*)backGroundImageName:(NSString*)name
{
    NSString *retname = objc_getAssociatedObject( self, g_backimgname );
    if( name )
    {
        objc_setAssociatedObject(self,g_backimgname, name, OBJC_ASSOCIATION_RETAIN);
        retname = name;
    }
    
    if( retname ==nil )
        retname = @"bg_launch";
    
    return retname;
}

-(UIImageView*)backGroudImageView
{
    UIImageView *bacgb = objc_getAssociatedObject( self, g_backgd );
    if( bacgb == nil )
    {
        bacgb = [[UIImageView alloc]initWithFrame:self.bounds];
        objc_setAssociatedObject(self, g_backgd, bacgb, OBJC_ASSOCIATION_RETAIN);
        bacgb.image = [UIImage imageNamed:[self backGroundImageName:nil]];
    }
    return bacgb;
}

-(UIImageView*)leftDoorImageView
{
    UIImageView *left = objc_getAssociatedObject( self, g_leftdoorkey );
    
    if( left == nil )
    {
        CGFloat halfw = self.bounds.size.width/2.0f;
        left = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,halfw ,self.bounds.size.height)];
        objc_setAssociatedObject(self, g_leftdoorkey, left, OBJC_ASSOCIATION_RETAIN);
    }
    
    return left;
}

-(UIImageView*)rightDoorImageView
{
    UIImageView *right = objc_getAssociatedObject( self, g_rigthdoorkey );
    if( right == nil )
    {
        CGFloat halfw = self.bounds.size.width/2.0f;
        right = [[UIImageView alloc]initWithFrame:CGRectMake(halfw, 0,halfw ,self.bounds.size.height)];
        
        objc_setAssociatedObject(self, g_rigthdoorkey, right, OBJC_ASSOCIATION_RETAIN);
    }
    
    return right;
}

-(UIImage*)snapShotViewSize
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
-(UIImage*)catImage:(UIImage*)img rect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//打开门的效果
-(void)openEffetct:(void(^)(BOOL bleft, BOOL bfinish))block
{
    objc_setAssociatedObject(self, g_block_open, block, OBJC_ASSOCIATION_RETAIN);
    
    CGFloat halfw = self.bounds.size.width/2.0f;
    CGFloat halfh = self.bounds.size.height/2.0f;
    UIImage* viewimg = [self snapShotViewSize];
    
    //首先截图
    self.leftDoorImageView.image = [self catImage:viewimg rect:CGRectMake(0.0f, 0, viewimg.size.width/2.0f, viewimg.size.height)];
    
    self.rightDoorImageView.image = [self catImage:viewimg rect:CGRectMake(viewimg.size.width/2.0f, 0, viewimg.size.width/2.0f, viewimg.size.height)];
    
    [self addSubview:self.leftDoorImageView];
    [self addSubview:self.rightDoorImageView];
    
    UIImageView* bgimg = self.backGroudImageView;
    [self insertSubview:bgimg belowSubview:self.leftDoorImageView];
    
    
    //然后执行动画
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(halfw*0.5f, halfh)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(-halfw*0.5f, halfh)];;
    animation.duration= 0.35f;
    animation.removedOnCompletion = NO;
    animation.fillMode= kCAFillModeForwards;
    animation.delegate = self;
    
    CABasicAnimation*animation1=[CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(halfw*1.5f, halfh)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(halfw*2.5f, halfh)];;
    animation1.duration= 0.35f ;
    animation1.removedOnCompletion = NO;
    animation1.fillMode= kCAFillModeForwards;
    animation1.delegate = self;

    [self.leftDoorImageView.layer addAnimation:animation forKey:@"left_open"];
    [self.rightDoorImageView.layer addAnimation:animation1 forKey:@"right_open"];

    objc_setAssociatedObject(self, g_bopened, @(1), OBJC_ASSOCIATION_RETAIN );
    
}

//关闭门的效果
-(void)closeEffect:(void(^)( BOOL bleft,BOOL bfinish))block
{
    id vvv = objc_getAssociatedObject(self, g_bopened);
    if( vvv == nil || [vvv intValue] == 0  )
    {
        return;
    }
    
    
    objc_setAssociatedObject(self, g_block_close, block, OBJC_ASSOCIATION_RETAIN);
    
    //需要和上面的openEffetct配合使用.
    
    CGFloat halfw = self.bounds.size.width/2.0f;
    CGFloat halfh = self.bounds.size.height/2.0f;
    
    //然后执行动画
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-halfw*0.5f, halfh)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(halfw*0.5f, halfh)];;
    animation.duration= 0.35f;
    animation.removedOnCompletion = NO;
    animation.fillMode= kCAFillModeForwards;
    animation.delegate = self;
    
    CABasicAnimation*animation1=[CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(halfw*2.5f, halfh)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(halfw*1.5f, halfh)];;
    animation1.duration= 0.35f;
    animation1.removedOnCompletion = NO;
    animation1.fillMode= kCAFillModeForwards;
    animation1.delegate = self;
    
    [self.rightDoorImageView.layer addAnimation:animation1 forKey:@"right_close"];
    [self.leftDoorImageView.layer addAnimation:animation forKey:@"left_close"];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if( anim == nil ) return;
    
    CAAnimation* right_close = [self.rightDoorImageView.layer animationForKey:@"right_close"];
    CAAnimation* left_close = [self.leftDoorImageView.layer animationForKey:@"left_close"];
    
    CAAnimation* right_open = [self.rightDoorImageView.layer animationForKey:@"right_open"];
    CAAnimation* left_open = [self.leftDoorImageView.layer animationForKey:@"left_open"];
    
    void(^ itcloseblock )( BOOL bleft,BOOL bfinish) = objc_getAssociatedObject(self, g_block_close);
    
    void(^ itopenblock )( BOOL bleft,BOOL bfinish) = objc_getAssociatedObject(self, g_block_open);
    
    if( anim == right_open )
    {
        if( itopenblock )
            itopenblock( NO,flag );
    }
    else if( anim == left_open )
    {
        if( itopenblock )
            itopenblock( YES,flag );
    }
    else if( anim == right_close )
    {
        if( itcloseblock )
            itcloseblock( NO,flag );
    }
    else if( anim == left_close )
    {
        if( itcloseblock )
            itcloseblock(YES,flag);
        
        [self cleanAll];
        
    }
    
}

-(void)cleanAll
{

    [self.leftDoorImageView     removeFromSuperview];
    [self.rightDoorImageView    removeFromSuperview];
    [self.backGroudImageView    removeFromSuperview];

    objc_setAssociatedObject(self, g_rigthdoorkey, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, g_leftdoorkey, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, g_backgd, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, g_backimgname, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, g_block_open, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, g_block_close, nil, OBJC_ASSOCIATION_RETAIN);
    
}





@end





