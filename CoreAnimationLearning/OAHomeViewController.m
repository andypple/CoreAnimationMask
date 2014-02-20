//
//  OAHomeViewController.m
//  CoreAnimationLearning
//
//  Created by Phat, Le Tan on 2/19/14.
//  Copyright (c) 2014 OnApp. All rights reserved.
//

#import "OAHomeViewController.h"

@interface OAHomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) UIView *bg;
@property (assign, nonatomic) CGPoint prePoint;
@property (strong, nonatomic) CALayer *imageLayer;
@property (strong, nonatomic) CAShapeLayer *maskLayer;

@end

@implementation OAHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bg = [[UIView alloc] initWithFrame:self.view.bounds];
    self.bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HGWM_1-7_landing"]];
    [self.view addSubview:self.bg];

    // create the mask that will be applied to the layer on top of the
    // yellow background
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
    self.maskLayer.frame = self.view.frame;

    // create the paths that define the mask
    UIBezierPath *maskLayerPath = [UIBezierPath bezierPath];
    [maskLayerPath appendPath:[UIBezierPath bezierPathWithRect:self.view.bounds]];
    // here you can play around with paths :)
    [maskLayerPath appendPath:[UIBezierPath bezierPathWithOvalInRect:(CGRect){{80, 80}, {140, 190}}]];
    [maskLayerPath appendPath:[UIBezierPath bezierPathWithOvalInRect:(CGRect){{100, 100}, {100, 150}}]];
    self.maskLayer.path = maskLayerPath.CGPath;

    // create the layer on top of the yellow background
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = self.view.layer.bounds;
    self.imageLayer.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.7f].CGColor;
//    imageLayer.backgroundColor = [UIColor blueColor].CGColor;

    // apply the mask to the layer
    self.imageLayer.mask = self.maskLayer;
    [self.view.layer addSublayer:self.imageLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.prePoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGFloat dentax = currentPoint.x - self.prePoint.x;
    CGFloat dentay = currentPoint.y - self.prePoint.y;

//    CGRect frame = self.bg.frame;
//    frame.origin.x += dentax;
//    frame.origin.y += dentay;
//    self.bg.frame = frame;

//    CALayer *mask = self.imageLayer.mask;
//    CGRect bounds = mask.frame;
//    bounds.origin.x +=dentax;
//    bounds.origin.y +=dentay;
//    mask.frame = bounds;

    CALayer *mask = self.maskLayer;
    mask.position = CGPointMake(mask.position.x + dentax, mask.position.y + dentay);
//    mask.affineTransform = CGAffineTransformMakeTranslation(dentax, dentay);
    self.prePoint = currentPoint;
}

@end
