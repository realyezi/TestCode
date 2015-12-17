//
//  ViewController.m
//  HelloWorld2
//
//  Created by SongEric on 15/12/8.
//  Copyright © 2015年 yssj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
 
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    UIView *_zoomingView;

}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSString *testBundlePath = [mainBundle pathForResource:@"TestBundle" ofType:@"bundle"];
//    NSBundle *bundle = [NSBundle bundleWithPath:testBundlePath];
//    UIImage *image = [UIImage imageNamed:@"114x114" inBundle: bundle compatibleWithTraitCollection:nil];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button setBackgroundImage:image forState:UIControlStateSelected];
//    [button setTitle:@"测试" forState:UIControlStateNormal];
//    [button setTitle:@"选中" forState:UIControlStateSelected];
//    [button setTitle:@"点击" forState:UIControlStateHighlighted];
//    
//    [button setFrame: self.view.frame];
    
//    [self.view addSubview:button];
    
    CGRect rc = self.view.bounds;
    rc.origin.x = (rc.size.width - 280)/2;
    rc.origin.y = (rc.size.height - 280)/2;
    rc.size.width = 280;
    rc.size.height = 280;
    
    _scrollView = [[UIScrollView alloc]initWithFrame: rc];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *testBundlePath = [mainBundle pathForResource:@"TestBundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:testBundlePath];
    [bundle load];
    
    UIImage *image = [UIImage imageNamed:@"ceshi3" inBundle: bundle compatibleWithTraitCollection:nil];
    CGSize size = image.size;
    CGRect rcContent = CGRectMake(0, 0, 280, size.height * 280/size.width);
    _scrollView.layer.borderWidth = 2;
    _scrollView.layer.borderColor = [[UIColor greenColor]CGColor];
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = rcContent.size;
    _scrollView.bounces = NO;
    
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.maximumZoomScale = 20.0f;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.bouncesZoom = NO;
    _scrollView.clipsToBounds = NO;
    _scrollView.contentOffset = CGPointMake(0, (_scrollView.contentSize.height - _scrollView.bounds.size.height)/2);


    _imageView = [[UIImageView alloc]initWithFrame:rcContent];
    _imageView.image = image;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.borderWidth = 3;
    _imageView.layer.borderColor = [[UIColor redColor]CGColor];

    _zoomingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    
    [_zoomingView addSubview:_imageView];
    [_scrollView addSubview:_zoomingView];
    _scrollView.delegate = self;
    
    [self setupToolbar];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationGestureRecognizer.delegate = self;
    [_scrollView addGestureRecognizer:rotationGestureRecognizer];
}

- (void) setupToolbar{
    if (!_toolbar) {
        CGRect rcScreen = [[UIScreen mainScreen] bounds];
        
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, rcScreen.size.height - 44, rcScreen.size.width, 44)];
        _toolbar.translucent = YES;
        _toolbar.userInteractionEnabled = YES;
        
        UIButton *previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        previewButton.frame = CGRectMake(10, 7, 40, 30);
        [previewButton setTitle:@"取消" forState:UIControlStateNormal];
        [previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [previewButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [previewButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake(10, 7, 40, 30);
        [selectedButton setTitle:@"选取" forState:UIControlStateNormal];
        [selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectedButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [selectedButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -11;
        
        UIBarButtonItem *previewIem = [[UIBarButtonItem alloc] initWithCustomView:previewButton];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:selectedButton];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        _toolbar.items = @[space, previewIem, flexItem, doneItem, space];

        [self.view addSubview:_toolbar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)gestureRecognizer{
    
    CGAffineTransform trans = _imageView.transform;
    trans = CGAffineTransformRotate(trans, gestureRecognizer.rotation);
    _imageView.transform = trans;
    gestureRecognizer.rotation = 0;
    
//    NSLog(@"contentSize%f,%f", _scrollView.contentSize.width, _scrollView.contentSize.height);
//    NSLog(@"contentOffset%f,%f", _scrollView.contentOffset.x, _scrollView.contentOffset.y);

}

#pragma mark UIScrollViewDelegate
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}
//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewWillBeginDragging");
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    NSLog(@"scrollViewDidEndDragging");
}
//将开始降速时
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidEndDecelerating");
}
//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}
//设置放大缩小的视图，要是uiscrollview的subview
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
{
    NSLog(@"viewForZoomingInScrollView");
    return _zoomingView;
}
//完成放大缩小时调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale;
{
    NSLog(@"scale between minimum and maximum. called after any 'bounce' animations");
}// scale between minimum and maximum. called after any 'bounce' animations

//如果你不是完全滚动到滚轴视图的顶部，你可以轻点状态栏，那个可视的滚轴视图会一直滚动到顶部，那是默认行为，你可以通过该方法返回NO来关闭它
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewShouldScrollToTop");
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidScrollToTop");
}


@end
