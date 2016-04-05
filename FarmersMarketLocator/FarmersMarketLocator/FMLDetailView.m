//
//  FMLDetailView.m
//  FarmersMarketLocator
//
//  Created by Magfurul Abeer on 4/1/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

#import "FMLDetailView.h"
#import "FMLMapViewController.h"

@implementation FMLDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [self setUpLabelWithText:@"Greenhouse Farmer's Market"
                                    textColor:[UIColor blackColor]];
        _addressLabel = [self setUpLabelWithText:@"123 Easy Street, Manhattan, NY, 11002"
                                       textColor:[UIColor blackColor]];
        _produceTextView = [self setUpProduceTextViewWithText:@"Fruits and Vegetables"
                                                 textColor:[UIColor blackColor]];
        _scheduleLabel = [self setUpLabelWithText:@"Mon-Fri 7am-4pm" textColor:[UIColor blackColor]];
        _arrowDownButton = [self setUpDownButton];
        _arrowUpButton = [self setUpUpButton];
    }
    [self addSubview:_nameLabel];
    [self addSubview:_addressLabel];
    [self addSubview:_arrowDownButton];
    [self addSubview:_arrowUpButton];
    [self addSubview:_produceTextView];
    [self addSubview:_scheduleLabel];
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:blurView];
        [self sendSubviewToBack:blurView];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(UILabel *)setUpLabelWithText:(NSString *)text textColor:(UIColor *)color {
    
    //create new label using parameters
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont fontWithName:@"Helvetica" size:16];
    label.textColor = color;
    label.numberOfLines = 0;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return label;
}

-(UITextView *)setUpProduceTextViewWithText:(NSString *)text textColor:(UIColor *)color {
 
    //create TextView to display produce list
    UITextView *textView = [[UITextView alloc]init];
    textView.text = text;
    textView.font = [UIFont fontWithName:@"Helvetica" size:16];
    textView.textColor = color;
    textView.editable = NO;
    textView.selectable = YES;
    textView.scrollEnabled = YES;
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.backgroundColor = [UIColor clearColor];
    return textView;
}

-(UIButton *)setUpDownButton {
    
    //create button with down arrow image
    UIButton *downButton = [[UIButton alloc]init];
    UIImage *arrowImage = [UIImage imageNamed:@"arrowdown"];
    [downButton setImage:arrowImage forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(hideButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    downButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    return downButton;
}

-(UIButton *)setUpUpButton{
    
    //create button with up arrow image
    UIButton *upButton = [[UIButton alloc]init];
    UIImage *arrowImage = [UIImage imageNamed:@"arrowup"];
    [upButton setImage:arrowImage forState:UIControlStateNormal];
    [upButton addTarget:self action:@selector(expandButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    upButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    return upButton;
}


-(void)constrainViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.arrowDownButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.arrowUpButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.produceTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scheduleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.widthAnchor constraintEqualToAnchor:self.superview.widthAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor].active = YES;
    [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    [self.heightAnchor constraintEqualToConstant:self.superview.frame.size.height * 0.4].active = YES;  //full Detail View is 2/5 of the frame size height
    
    
    [self.arrowUpButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.arrowUpButton.centerXAnchor constraintLessThanOrEqualToAnchor:self.centerXAnchor constant:-20].active = YES;
    
    [self.arrowDownButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.arrowDownButton.centerXAnchor constraintGreaterThanOrEqualToAnchor:self.centerXAnchor constant:20].active = YES;

    
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.arrowDownButton.bottomAnchor constant:3].active = YES;
    self.nameLabel.textAlignment = NSTextAlignmentCenter; //to center the text
    [self.nameLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20].active = YES;
    [self.nameLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-20].active = YES;
    
    [self.addressLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:5].active = YES;
    [self.addressLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20].active = YES;
    [self.addressLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-20].active = YES;
    
    [self.scheduleLabel.topAnchor constraintEqualToAnchor:self.addressLabel.bottomAnchor constant:5].active = YES;
    [self.scheduleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20].active = YES;
    [self.scheduleLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-20].active = YES;
    
    CGFloat textViewPadding = 30; //30 here, makes it perfectly alligned with text labels
    CGFloat textViewWidth = self.bounds.size.width - textViewPadding;
    CGFloat textViewHeight = self.bounds.size.height * 0.3;
    [self.produceTextView.topAnchor constraintEqualToAnchor:self.scheduleLabel.bottomAnchor constant:3].active = YES;
    [self.produceTextView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.produceTextView.widthAnchor constraintEqualToConstant:textViewWidth].active = YES;
    [self.produceTextView.heightAnchor constraintEqualToConstant:textViewHeight].active = YES;
    
}

-(void)hideButtonPressed {
    [self hideDetailView];
    MKCoordinateRegion region = self.previousRegion;
    NSValue *regionStruct = [NSValue value:&region withObjCType:@encode(MKCoordinateRegion)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZoomBackOutKThxBai" object:regionStruct];
}

-(void)hideDetailView {
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
        
    } completion:nil];
}

//shows the Detail View only up to half of its height
-(void)showDetailView {
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height/2);
        
    } completion:nil];
}

//pressing Up Arrow calls this method to expand the Detail View
-(void)expandButtonPressed {
    
    [self showFullDetailView];
}

//shows full Detail View
-(void)showFullDetailView {
 
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
