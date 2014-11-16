//
//  LineView.m
//  Ibeacon
//
//  Created by chenwg on 14-11-15.
//  Copyright (c) 2014年 chenwg.com. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withX:(CGFloat)xx Y:(CGFloat)yy
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawMyline:xx layerY:yy];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //[self drawMyLine];
}

//- (void)drawMyLine
//{
//    //draw line
//    CGContextRef context    =UIGraphicsGetCurrentContext();//获取画布
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
//    CGContextSetShouldAntialias(context,NO);//设置线条平滑，不需要两边像素宽
//    CGContextSetLineWidth(context,2.0f);//设置线条宽度
//    CGContextMoveToPoint(context,153,6); //线条起始点
//    CGContextAddLineToPoint(context,153,145);//线条结束点
//    CGContextStrokePath(context);//结束，也就是开始画
//}



-(void) drawMyline: (CGFloat)layerX layerY: (CGFloat) layerY{
    //draw line
    CGContextRef context    =UIGraphicsGetCurrentContext();//获取画布
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
    CGContextSetShouldAntialias(context,NO);//设置线条平滑，不需要两边像素宽
    CGContextSetLineWidth(context,2.0f);//设置线条宽度
    CGContextMoveToPoint(context,layerX,layerY); //线条起始点
    CGContextAddLineToPoint(context,153,145);//线条结束点
    CGContextStrokePath(context);//结束，也就是开始画
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
