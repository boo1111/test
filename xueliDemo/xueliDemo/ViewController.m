//
//  ViewController.m
//  xueliDemo
//
//  Created by tangjin on 15/6/10.
//  Copyright (c) 2015年 xuelihudong. All rights reserved.
//
#define RATE 5
#import "ViewController.h"
#import "UIViewExt.h"
@interface ViewController ()
{
    UIImageView *imgView;
    CGPoint center;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *bgImage=[UIImage imageNamed:@"实验裙"];
    
    // 图片的尺寸
    CGFloat imageW =bgImage.size.width/RATE*2;
    CGFloat imageH = bgImage.size.height/RATE*2;
    
    for (int i=0; i<RATE*RATE; i++) {
        CGRect clipRect = CGRectMake((i%RATE)*imageW, (i/RATE)*imageH, imageW, imageH);
        CGImageRef smallImage = CGImageCreateWithImageInRect(bgImage.CGImage, clipRect);
        UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake((i%RATE)*imageW/2, i/RATE*imageH/2, imageW/2, imageH/2)];
        center=imageview.center;
        imageview.userInteractionEnabled=YES;
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        imageview.tag=i;
        [imageview addGestureRecognizer:panGestureRecognizer];
        UIImage *sourceIMG= [UIImage imageWithCGImage:smallImage];
        [imageview setImage:sourceIMG];
        [self.view addSubview:imageview];
    }
    // Do any additional setup after loading the view, typically from a nib.
}


// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    CGPoint point= [panGestureRecognizer locationInView:view];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        center=view.center;
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
//        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
                //        pinchGestureRecognizer.scale = 1;
        if (point.x<view.width/2) {
            view.x=view.x+translation.x/10;
            view.width=view.width-translation.x/10;
           
        }
        else{
            view.width=view.width+translation.x/10;
        }
        
        if (point.y<view.height/2) {
            view.height=view.height-translation.y/10;
            view.y+=translation.y/10;
        }
        else{
            
            view.height=view.height+translation.y/10;
        }
        
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        
    }
    if (panGestureRecognizer.state==UIGestureRecognizerStateEnded) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];

//        CABasicAnimation *position = [CABasicAnimation animation];
        
//        position.keyPath = @"position";
        
//        position.toValue = [NSValue valueWithCGPoint:CGPointMake(view.x+translation.x/  , translation.y/10+view.y)];
        
        CABasicAnimation *scale = [CABasicAnimation animation];
        
        scale.keyPath = @"transform.scale";
        
        scale.toValue = @1.1;
        
        
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        group.animations = @[scale];
        
        group.duration = .2;
        
        // 取消反弹
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        
        
        [view.layer addAnimation:group forKey:nil];
//        view.center=center;
//        view.x=view.x-1;
//        view.y=view.y-1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
