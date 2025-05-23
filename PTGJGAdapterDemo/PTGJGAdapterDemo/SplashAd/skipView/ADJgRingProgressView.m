//
//  ADJgProcessView.m
//  ADJgSDKDemo
//
//  Created by 技术 on 2020/11/3.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "ADJgRingProgressView.h"

@interface ADJgRingProgressView ()

@property (nonatomic, strong) UILabel *percentage;

@end

@implementation ADJgRingProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = [self frameForContainer];
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
      self.backgroundColor = [UIColor clearColor];
      //百分比标签
    if (!_percentage) {
        _percentage = [[UILabel alloc] initWithFrame:self.bounds];
        _percentage.font = [UIFont boldSystemFontOfSize:12.0f];
        _percentage.textColor = [UIColor orangeColor];
        _percentage.textAlignment = NSTextAlignmentCenter;
    }
    [self addSubview:_percentage];
      
  }

  - (void)setProgress:(NSInteger)progress {
      _progress = progress;
      _percentage.text = [NSString stringWithFormat:@"%ld",(long)_progress];
      
  }

  - (void)drawRect:(CGRect)rect {
      UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
      backgroundPath.lineWidth = 5.0;
      [[UIColor whiteColor] set];
      backgroundPath.lineCapStyle = kCGLineCapRound;
      backgroundPath.lineJoinStyle = kCGLineJoinRound;
      CGFloat radius = (MIN(rect.size.width, rect.size.height) - 5.0) * 0.5;
      [backgroundPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:-M_PI * 0.5 endAngle:-M_PI * 0.5 + M_PI * 2  clockwise:YES];
      [backgroundPath stroke];

      UIBezierPath *ringPath = [[UIBezierPath alloc] init];//圆环路径
      ringPath.lineWidth = 5.0;//圆环宽度
      [[UIColor blueColor] set];//环的颜色
      ringPath.lineCapStyle = kCGLineCapRound;
      ringPath.lineJoinStyle = kCGLineJoinRound;
      [ringPath addArcWithCenter:CGPointMake(rect.size.width*0.5, rect.size.height*0.5) radius:radius startAngle:-M_PI*0.5 endAngle:-M_PI*0.5 + M_PI*2*(_progress/5.0) clockwise:YES];
      [ringPath stroke];
      
  }

- (void)setLifeTime:(NSInteger)lifeTime {
    self.progress = lifeTime;
    [self setNeedsDisplay];
}


- (CGRect)frameForContainer {
#define kSkipViewWidth 40
#define kSkipViewHeight 40
#define kSkipViewRightMargin 12
#define kSkipViewTopMargin 8
// 状态栏高度  此处未作是否刘海屏幕判断
#define kADJGStatusBarHeight 44
    CGFloat y = kADJGStatusBarHeight + kSkipViewTopMargin;
    CGFloat x = UIScreen.mainScreen.bounds.size.width - kSkipViewRightMargin - kSkipViewWidth;
    return CGRectMake(x, y, kSkipViewWidth, kSkipViewHeight);
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


@end
