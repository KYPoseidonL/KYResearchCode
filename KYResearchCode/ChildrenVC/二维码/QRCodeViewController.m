//
//  QRCodeViewController.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/8/10.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeGenerator.h"
#import "Scan_VC.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@interface QRCodeViewController ()<UITextFieldDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *qrTextField;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setup {

    self.qrImageView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer*longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [self.qrImageView addGestureRecognizer:longPress];
    
    self.qrTextField.delegate = self;
    self.qrTextField.layer.masksToBounds = YES;
    self.qrTextField.returnKeyType = UIReturnKeyDone;
    self.qrTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.qrTextField.font = [UIFont boldSystemFontOfSize:15.0];
    self.qrTextField.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)scanAction:(id)sender {
    
    Scan_VC *vc = [[Scan_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)createAction:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"6824500_006_thumb.jpg"];
    NSString *tempStr = self.qrTextField.text.length == 0 ? @"KYPoseidonL" : self.qrTextField.text;
    UIImage *tempImage = [QRCodeGenerator qrImageForString:tempStr imageSize:360.f Topimg:image withColor:RandomColor];
    self.qrImageView.image = tempImage;
}

#pragma mark-> 长按识别二维码
- (void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        
        UIImageView *tempImageView = (UIImageView *)gesture.view;
        if(tempImageView.image){
            
            //1. 初始化扫描仪，设置设别类型和识别质量
            CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
            //2. 扫描获取的特征组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImageView.image.CGImage]];
            //3. 获取扫描结果
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

#pragma mark->textFiel delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
