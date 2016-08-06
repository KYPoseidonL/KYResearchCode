//
//  TestViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 16/3/31.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "TestViewController.h"
#import "TaskModel.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (weak, nonatomic) IBOutlet UIWebView *testWebView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    
    [self testModelData];
    
}

- (void)testModelData {

    NSDictionary *result = [KYDataService requestDataOfJsonName:@"test"];
    TaskModel *taskModel = [TaskModel mj_objectWithKeyValues:result];
    TaskListModel *model = taskModel.resContent.tasklist.firstObject;
    DDLogDebug(@"%@", model);
}

- (void)setup {
    
    [self.testImageView sd_setImageWithURL:[NSURL URLWithString:@"http://assets.sbnation.com/assets/2512203/dogflops.gif"] placeholderImage:nil];
    
//    self.testWebView.scalesPageToFit = YES;
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://assets.sbnation.com/assets/2512203/dogflops.gif"]];
//    [self.testWebView loadRequest:urlRequest];
    
    
    BOOL isFlag = [KYUtility validateUserName:@"fdas23"];
    if (isFlag) {
        DDLogDebug(@"验证成功");
    } else {
        DDLogDebug(@"验证失败");
    }
}


//1、是 “压” 文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降，
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
        DDLogDebug(@"%@", @([imageData length]));
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

//2、是 “缩” 文件的尺寸变小，也就是像素数减少。长宽尺寸变小，文件体积同样会减小。
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (void)compressedPostImage {


    UIImage *image = [UIImage imageNamed:@"wanshenjie"];
    
    DDLogDebug(@"%@", NSStringFromCGSize(image.size));
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > 1000) {
        image = [self imageCompressForSize:image targetSize:CGSizeMake(1000.f, 1000.f*height/width)];
    }
    
    if (height > 1000) {
        image = [self imageCompressForSize:image targetSize:CGSizeMake(1000.f*width/height, 1000.f)];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [self compressImage:image toMaxFileSize:102400];
    });

}


@end
