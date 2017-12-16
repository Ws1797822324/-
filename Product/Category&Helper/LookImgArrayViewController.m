//
//  LookImgArrayViewController.m
//  Jewelry
//
//  Created by HJ on 2017/4/5.
//  Copyright © 2017年 HJ. All rights reserved.
//

#import "LookImgArrayViewController.h"
#import <Photos/Photos.h>
#import "SDBrowserImageView.h"


@interface LookImgArrayViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *_zoomingScroolView;
}

@property (nonatomic,copy) NSString * numStr;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UILabel * label;
@property (nonatomic,strong)NSArray * carImageArray;
@property(nonatomic,retain)UIImage*img;

@end

@implementation LookImgArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSString * str in self.imgArray)
    {
        
        if ([str isEqualToString:@""]){
            
            [self.imgArray removeObject: str];
            
            break;//一定要有break，否则会出错的。
        }
    }
    
    self.carImageArray = self.imgArray;
    
    self.view.backgroundColor=[UIColor blackColor];
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  kScreenHeight)];
    
    self.scrollView.delegate=self;
    self.scrollView.contentSize=CGSizeMake(kWidth * self.carImageArray.count, 0);
    
    self.scrollView.pagingEnabled=YES;
    

    for (int i=0 ; i< self.carImageArray.count; i++) {

        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        
        // 双击放大图片
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
        [tap requireGestureRecognizerToFail:doubleTap];

        
        doubleTap.numberOfTapsRequired = 2;

        
        SDBrowserImageView * _imageview=[[SDBrowserImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        _imageview.tag = i;
        _imageview.contentMode=UIViewContentModeScaleAspectFit;
        //        NSString * urlStr=[NSString stringWithFormat:@"%@%@",BaseImgOtherUrl,self.carImageArray[i]];
                NSString * urlStr=[NSString stringWithFormat:@"%@%@",@"",self.carImageArray[i]];
        
        [_imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"1-1加载图"]];
        [self.scrollView addSubview:_imageview];
        
        _imageview.userInteractionEnabled = YES;
        [_imageview addGestureRecognizer:doubleTap];
        [_imageview addGestureRecognizer:tap];
    }
    
    [self.view addSubview:self.scrollView];
    
    self.label= [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight-69-30, kWidth, 30)];
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.textColor=[UIColor whiteColor];
    self.label.text = [NSString stringWithFormat:@"%ld/%ld",self.num,self.imgArray.count];
    [self.view addSubview:self.label];
    
    [self.scrollView setContentOffset:CGPointMake((self.num-1)*kScreenWidth,0) animated:YES];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.num = (int)scrollView.contentOffset.x/kScreenWidth +1;
    self.numStr = [NSString stringWithFormat:@"%ld",self.num];
    self.label.text = [NSString stringWithFormat:@"%@/%ld",self.numStr,self.imgArray.count];
}

//  单击返回
- (void)tap
{
    CATransition * animation = [CATransition animation];
    animation.duration = 0.5;    //  时间
    animation.type = @"kCATransitionFade";
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    self.myClick((int)self.num);
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}


- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer
{
    SDBrowserImageView *imageView = (SDBrowserImageView *)recognizer.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    
    SDBrowserImageView *view = (SDBrowserImageView *)recognizer.view;
    
    [view doubleTapToZommWithScale:scale];
}




@end
