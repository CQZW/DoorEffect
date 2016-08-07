//
//  UIView+DoorEffect.h
//  testDoorEffect
//
//  Created by zzl on 16/7/24.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DoorEffect)

//打开门的效果 time = 0 ==> 0.35 ,aboveview = nil ==> self ,表示在哪个view上面做效果,aboveview通常是开门之后要显示的view
-(void)openEffetct:(float)time  aboveview:(UIView*)aboveview block:(void(^)(BOOL bleft, BOOL bfinish))block;

//关闭门的效果
-(void)closeEffect:(float)time  block:(void(^)( BOOL bleft,BOOL bfinish))block;


@end
