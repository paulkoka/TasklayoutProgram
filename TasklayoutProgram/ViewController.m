//
//  ViewController.m
//  TasklayoutProgram
//
//  Created by paul on 6/28/18.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UIView* blueView;
@property (nonatomic, strong) UIView* redView;

@property (nonatomic, strong) NSMutableArray* commonConstraints;
@property (nonatomic, strong) NSMutableArray* compactConstraints;
@property (nonatomic, strong) NSMutableArray* regularConstraints;

@property (nonatomic, strong) UIButton* redButton;
@property (nonatomic, strong) UIButton* blueButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.blueView = [[UIView alloc] initWithFrame:CGRectZero];
    self.blueView.backgroundColor = UIColor.blueColor;
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.blueView];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectZero];
    self.redView.backgroundColor = UIColor.redColor;
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.redView];
    
    [self addConstraints];
    
    self.blueButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.redButton = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [self layoutButton:_blueButton toView:_blueView];
    [self layoutButton:_redButton toView:_redView];
    
    self.blueButton.accessibilityIdentifier = @"blueButton";
    self.redButton.accessibilityIdentifier = @"redButton";
    self.blueView.accessibilityIdentifier = @"blueView";
    self.redView.accessibilityIdentifier = @"redView";

}


- (void)resize:(UIButton *)sender {
    

    NSLayoutConstraint *parameter = [[NSLayoutConstraint alloc] init];
    
    [NSLayoutConstraint deactivateConstraints:self.commonConstraints];
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        if ([sender isEqual: self.blueButton]) {
            parameter = [self.redView.widthAnchor constraintEqualToAnchor:self.blueView.widthAnchor multiplier:3.0];
        }
        
        if ([sender isEqual: self.redButton])
        {
            parameter = [self.redView.widthAnchor constraintEqualToAnchor:self.blueView.widthAnchor multiplier:0.3];
        }
         [self.commonConstraints replaceObjectAtIndex:1 withObject:parameter];
    } else{
        
        if ([sender isEqual: self.blueButton]) {
            parameter = [self.redView.heightAnchor constraintEqualToAnchor:self.blueView.heightAnchor multiplier:3.0];
        }
        
        if ([sender isEqual: self.redButton])
        {
            parameter = [self.redView.heightAnchor constraintEqualToAnchor:self.blueView.heightAnchor multiplier:0.3];
        }
    
        [self.commonConstraints replaceObjectAtIndex:0 withObject:parameter];
        
    }
    

        [NSLayoutConstraint activateConstraints:self.commonConstraints];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    
}



- (void)layoutButton: (UIButton*) button toView:(UIView*)view{
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [button setTitle:@"Tap" forState:UIControlStateNormal];
    
    [button addTarget:self
                       action:@selector(resize:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];

    NSLayoutConstraint *bXConstraint = [button.centerXAnchor constraintEqualToAnchor:view.centerXAnchor];
    bXConstraint.identifier = @"bXConstraint";
    NSLayoutConstraint *bYConstraint = [button.centerYAnchor constraintEqualToAnchor:view.centerYAnchor];
    bYConstraint.identifier = @"bYConstraint";
    NSLayoutConstraint *bWidthConstraint = [button.widthAnchor constraintEqualToAnchor:view.widthAnchor];
    bWidthConstraint.identifier = @"bWidthConstraint";
    NSLayoutConstraint *bHeightConstraint = [button.heightAnchor constraintEqualToAnchor:view.heightAnchor];
    bHeightConstraint.identifier = @"bHeightConstraint";
    
    [NSLayoutConstraint activateConstraints:@[bXConstraint, bYConstraint, bWidthConstraint, bHeightConstraint]];
}


-(void) addConstraints{
    
    [self commonConstraintsSetToDefault];
    
    UILayoutGuide* guide = self.view.safeAreaLayoutGuide;
 
    NSLayoutConstraint* compactPairAnchor = [self. blueView.bottomAnchor constraintEqualToAnchor:self.redView.topAnchor];
    NSLayoutConstraint* compactWidth = [self.blueView.widthAnchor constraintEqualToAnchor:guide.widthAnchor];

    
    NSLayoutConstraint* regularPairAnchor = [self. blueView.trailingAnchor constraintEqualToAnchor:self.redView.leadingAnchor];
    NSLayoutConstraint* regularHeightAnchir = [self.blueView.heightAnchor constraintEqualToAnchor:guide.heightAnchor];
    NSLayoutConstraint* regularTrailingRedAnchir = [self.redView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor];
  
  
    self.compactConstraints = [NSMutableArray arrayWithObjects:compactWidth, compactPairAnchor, nil];
    
    self.regularConstraints = [NSMutableArray arrayWithObjects:
                               regularHeightAnchir,
                               regularPairAnchor,
                               regularTrailingRedAnchir,
                               nil];
    
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        [NSLayoutConstraint activateConstraints:self.regularConstraints];
    } else{
        [NSLayoutConstraint activateConstraints:self.compactConstraints];
    }
}

-(void) willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [self commonConstraintsSetToDefault];
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular ) {
        [NSLayoutConstraint deactivateConstraints:self.compactConstraints];
        [NSLayoutConstraint activateConstraints:self.regularConstraints];
    } else{
        [NSLayoutConstraint deactivateConstraints:self.regularConstraints];
        [NSLayoutConstraint activateConstraints:self.compactConstraints];
    }
    
    
}

-(void) commonConstraintsSetToDefault{
    
    [NSLayoutConstraint deactivateConstraints:self.commonConstraints];
    
    UILayoutGuide* guide = self.view.safeAreaLayoutGuide;
    
    NSLayoutConstraint *commonBlueLeadingAnchor = [self.blueView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor];
    NSLayoutConstraint* commonBlueTopAnchor = [self.blueView.topAnchor constraintEqualToAnchor:guide.topAnchor];
    NSLayoutConstraint* commonWidthAnchor = [self.blueView.widthAnchor constraintEqualToAnchor:self.redView.widthAnchor];
    NSLayoutConstraint* commonHeigthAnchor = [self.blueView.heightAnchor constraintEqualToAnchor:self.redView.heightAnchor];
    NSLayoutConstraint *commonRedBottomAnchor = [self.redView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor];
    
    self.commonConstraints = [NSMutableArray arrayWithObjects:
                              commonHeigthAnchor,
                              commonWidthAnchor,
                              commonBlueTopAnchor,
                              commonBlueLeadingAnchor,
                              commonRedBottomAnchor,
                              nil];
    [NSLayoutConstraint activateConstraints:self.commonConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
