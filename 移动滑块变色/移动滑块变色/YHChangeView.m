//
//  YHChangeView.m
//  移动滑块变色
//
//  Created by 施永辉 on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHChangeView.h"

@interface YHChangeView ()

//最外层的View
@property (nonatomic,strong)UIView * mainView;
/**中间的View */
@property (nonatomic,strong)UIView * middleView;
//单个格子的高度
@property (nonatomic,assign)CGFloat height;
@end


@implementation YHChangeView

- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _height = self.frame.size.height / titleArr.count;
        //添加最里面Label
        for (int i = 0; i <titleArr.count; i++) {
           //调用Label加工厂
            [self addSubview:[self returnLabel:titleArr[i] andFrame:CGRectMake(0, i * _height, self.frame.size.width, _height) andColor:[UIColor blackColor]]];
            }
            //新式自定义控件写法  *****
        _middleView = ({
                UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _height)];
                midView.backgroundColor = [UIColor lightGrayColor];
                //设置不显示超出的部分
                midView.clipsToBounds = YES;
                midView.userInteractionEnabled = YES;
                midView;
            });
            [self addSubview:_middleView];
            
        _mainView = ({
                UIView * labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _middleView.frame.size.width, _middleView.frame.size.height)];
                for (int i = 0;i < titleArr.count ; i++)
                {
                    [labelView addSubview:[self returnLabel:titleArr[i] andFrame:CGRectMake(0, i*_height, self.frame.size.width, _height) andColor:[UIColor whiteColor]]];
                }
                labelView;
            });
            [_middleView addSubview:_mainView];
            //添加拖动手势
            UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(touchMiddleView:)];
            [_middleView addGestureRecognizer:pan];
        
    }
    return self;
}
- (void)touchMiddleView:(UIPanGestureRecognizer *)sender
{
    /*
     locationInView:获取到的是手指点击屏幕实时的坐标点；
     translationInView：获取到的是手指移动后，在相对坐标中的偏移量
     */
    CGPoint pt = [sender translationInView:self];
    
    CGPoint midCenter = _middleView.center;
    CGPoint labelCenter = _mainView.center;
    
    midCenter.y += pt.y;
    labelCenter.y -= pt.y;
    
    //边界
    if (midCenter.y > self.frame.size.height - _height/2.0)
    {
        midCenter.y = self.frame.size.height - _height/2.0 ;
        labelCenter.y = -self.frame.size.height + _height*1.5;
    }
    if (midCenter.y < _height/2.0)
    {
        midCenter.y = _height/2.0 ;
        labelCenter.y = _height/2.0;
    }
    
    _middleView.center = midCenter;
    _mainView.center = labelCenter;
    
    [sender setTranslation:CGPointZero inView:self];
}
/**
 
    ==  Label 加工厂 ==
 
 *   对传入的Label进行加工处理
 *
 *  @param   rect 坐标
 *  @param   color yans
 *  @return  label 返回label
 *  有需要的可以自己更改里面Label的属性
 *
 */
- (UILabel *)returnLabel:(NSString *)title andFrame:(CGRect)rect andColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont boldSystemFontOfSize:40];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
