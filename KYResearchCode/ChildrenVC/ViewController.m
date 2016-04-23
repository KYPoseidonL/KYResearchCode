//
//  ViewController.m
//  DemoTest
//
//  Created by iOS Developer 3 on 15/9/23.
//  Copyright (c) 2015年 iOS Developer 3. All rights reserved.
//

#import "ViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "ShareUIView.h"
#import "ShareTool.h"
#import "DataBaseViewController.h"
#import "KYWebViewViewController.h"
#import "UserLoginViewController.h"

#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import "UINavigationBar+Awesome.h"
#import "AppListViewController.h"
#import "NetworkingViewController.h"
#import "TestViewController.h"
#import "UDIDViewController.h"
#import "ShowCustomAnimationController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UMSocialUIDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *_pinImageView;
    CGFloat _lastScale;
    BOOL a[100];
        ShareTool           *_shareTool;
}
@property (assign,nonatomic) int isVideo;//是否录制视频，如果为1表示录制视频，0代表拍照
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic)  UIImageView *photo;//照片展示视图
@property (strong ,nonatomic) AVPlayer *player;//播放器，用于录制完视频后播放视频
@property (nonatomic, strong) ShareUIView *shareUIView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"StudyDemo";
    
    //通过这里设置当前程序是拍照还是录制视频
    _isVideo=YES;

    [self createTabelView];
    
    NSString *ipString = [self getDeviceIPIpAddresses];
    DDLogDebug(@"%@", ipString);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    NSInteger postion = 2;
    
    NSInteger oneCount = [self getOneWithCount:postion];
    
    //11
    for (int i = 0; i < oneCount; i ++) {
        
        NSInteger num = [self getRealIndexWithComposition:postion withIndex:i];
        
        switch (num) {
            case 1: DDLogDebug(@"高位为1"); break;
            case 2: DDLogDebug(@"低位为1"); break;
        }
    }
}

- (NSInteger)getOneWithCount:(NSInteger)v {
    
    NSInteger number = 0;
    while(v){
        v &= (v-1);
        number++;
    }
    return number;
}

- (NSInteger)getRealIndexWithComposition:(NSInteger)composition withIndex:(NSInteger)index {
    
    int realIndex = 0;
    int num = -1;
    for(int i = 1;i < 3;++i ){
        BOOL is = (composition>>(3-1-i))&0x01;
        if( is )
            num += 1;
        
        if( index == num ){
            realIndex = i;
            break;
        }
    }
    return realIndex;
}

- (NSString *)getDeviceIPIpAddresses {
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    if (sockfd < 0) return nil;
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    close(sockfd);
    
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        
        if (ips.count > 0){
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
            
        }
        
    }
    
    return deviceIP;
}

- (ShareUIView *)shareUIView {
    
    if (!_shareUIView) {
        UIImage *postImg = nil;
        postImg = [UIImage imageNamed:@"test1.jpg"];

        _shareTool = [[ShareTool alloc] initWithViewController:self shareImage:postImg descpContent:@"这是一条测试信息"];
        _shareUIView = [_shareTool getShareViewWithShareTool];
        
        _shareTool.fromeWhere = @"WebViewViewController";
        [self.view.window addSubview:_shareUIView];
        [_shareUIView setNeedsLayout];
        
    }
    return _shareUIView;

}
#pragma mark -LazyLoad
- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[@"录制视频", @"分享测试", @"数据库", @"WebView", @"登陆账号联想", @"已安装app信息", @"网络请求", @"测试类", @"设备唯一标识符", @"自定义动画展示", @"测试", @"测试", @"测试", @"测试", @"测试", @"测试", @"测试", @"测试", @"测试"];
    }
    return _dataList;
}

- (UIImageView *)photo {

    if (!_photo) {
        _photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width*0.25, kScreen_Width*0.25*1.25)];
        _photo.bottom = kScreen_Height;
        _photo.centerX = kScreen_Width*0.5;
    }
    return _photo;
}

- (void)createTabelView {

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.contentInset = UIEdgeInsetsMake(-kNavigationBar_Height, 0, 0, 0);
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        } break;
        case 1: {
            [_shareUIView removeFromSuperview];
            _shareUIView = nil;
            
            [self shareUIView];
            [_shareTool shareBtnMethod];
        } break;
        case 2: {
            
            DataBaseViewController *dataBaseVC = [[DataBaseViewController alloc] init];
            dataBaseVC.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:dataBaseVC animated:YES];
        } break;
        case 3: {
            KYWebViewViewController *vc = [[KYWebViewViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 4: {
            UserLoginViewController *vc =[[UserLoginViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 5: {
            AppListViewController *vc =[[AppListViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 6: {
            NetworkingViewController *vc =[[NetworkingViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 7: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TestViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"TestID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 8: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TestViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SUDID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 9: {
            ShowCustomAnimationController *vc =[[ShowCustomAnimationController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 200.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200.f)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:headView.bounds];
    imageView.image = [UIImage imageNamed:@"head.jpg"];
    [headView addSubview:imageView];
    
    return headView;
}

#pragma mark - UI事件

#pragma mark - UIImagePickerController代理方法
//完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image;
        //如果允许编辑则获得编辑后的照片，否则获取原始照片
        if (self.imagePicker.allowsEditing) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        }else{
            image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        }
        [self.photo setImage:image];//显示照片
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        DDLogDebug(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    DDLogDebug(@"取消");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 私有方法
-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
        _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
        if (self.isVideo) {
            _imagePicker.mediaTypes=@[(NSString *)kUTTypeMovie];
            _imagePicker.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
            
        }else{
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        }
        _imagePicker.allowsEditing=YES;//允许编辑
        _imagePicker.delegate=self;//设置代理，检测操作
    }
    return _imagePicker;
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        DDLogDebug(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        DDLogDebug(@"视频保存成功.");
        //录制完之后自动播放
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        _player=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame=self.photo.frame;
        [self.photo.layer addSublayer:playerLayer];
        [_player play];
        
    }
}

- (void)pin:(UIPinchGestureRecognizer *)pin {

    DDLogDebug(@"%f", pin.scale);
    pin.scale=pin.scale-_lastScale+1;
    
    _pinImageView.transform=CGAffineTransformScale(_pinImageView.transform, pin.scale,pin.scale);
    _lastScale=pin.scale;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = MIN(1, 1 - ((64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
//    DDLogDebug(@"%f", offsetY);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

@end
