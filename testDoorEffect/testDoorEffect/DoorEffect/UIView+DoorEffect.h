//
//  UIView+DoorEffect.h
//  testDoorEffect
//
//  Created by zzl on 16/7/24.
//  Copyright © 2016年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DoorEffect)

-(NSString*)backGroundImageName:(NSString*)name;

//打开门的效果
-(void)openEffetct:(void(^)(BOOL bleft, BOOL bfinish))block;

//关闭门的效果
-(void)closeEffect:(void(^)(BOOL bleft,BOOL bfinish))block;

@end
