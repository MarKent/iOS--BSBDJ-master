//
//  MKSeeBigPictureViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/11/3.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>//iOS9之后使用
#import <SVProgressHUD.h>

static NSString *MKBSBDJAlbumName = @"MK百思不得姐";
@interface MKSeeBigPictureViewController ()<UIScrollViewDelegate>

/** 滑动视图 */
@property (nonatomic , weak)UIScrollView *scrollView;
/** 图片视图 */
@property (nonatomic , weak)UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end

@implementation MKSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    //添加图片视图
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            
            self.saveButton.enabled = YES;
        }
    }];
    [scrollView addSubview:imageView];
    
    //计算尺寸
    imageView.mk_X = 0;
    imageView.mk_width = scrollView.mk_width;
    imageView.mk_height = self.topicModel.height * imageView.mk_width / self.topicModel.width;
    if (imageView.mk_height < [UIScreen mainScreen].bounds.size.height) {
        //小图居中显示
        imageView.center = scrollView.center;
    }else {
        //大图滚动
        imageView.mk_Y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.mk_height);
    }
    self.scrollView = scrollView;
    self.imageView = imageView;
    
    //添加缩放
    CGFloat scale = self.topicModel.width / imageView.mk_width;
    if (scale > 1.0) {
        self.scrollView.maximumZoomScale = scale;
    }else {
        self.scrollView.maximumZoomScale = 3;
    }
}

#pragma mark - 按钮点击
- (IBAction)saveClick {
    
    //1.判断用户是否授权应用访问系统相册
    /*
     PHAuthorizationStatusNotDetermined = 0, // 用户尚未选择是否允许
     PHAuthorizationStatusRestricted,        // 家长控制等系统原因不能访问相册
     PHAuthorizationStatusDenied,            // 用户拒绝应用访问系统相册
     PHAuthorizationStatusAuthorized         // 用户已允许访问系统相册
     */
    PHAuthorizationStatus myStatus = [PHPhotoLibrary authorizationStatus];
    if (myStatus == PHAuthorizationStatusRestricted) {
        [SVProgressHUD showErrorWithStatus:@"系统原因,无法访问相册!"];
    }else if (myStatus == PHAuthorizationStatusDenied) {
        [SVProgressHUD showErrorWithStatus:@"您已拒绝本应用访问系统相册!前去设置可允许访问"];
    }else if (myStatus == PHAuthorizationStatusNotDetermined) {
        //弹框请求是否允许访问系统相册
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self saveImage];
            }else {
                [SVProgressHUD showErrorWithStatus:@"您拒绝了访问相册请求!"];
            }
        }];
    }else if (myStatus == PHAuthorizationStatusAuthorized) {
        [self saveImage];
    }
}
- (void)saveImage {

    /***在Photo.h框架中
     *对系统相册的增删改操作,都要在
      [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{}
        completionHandler:^(BOOL success, NSError * _Nullable error) {}];
      这个方法中的block块中异步进行
     *PHAsset : 一个资源,如一张图片或一个视频
     *PHAssetsCollection : 相册
     ***/
    
    //获取保存的图片和创建的相册的本地标识
    __block NSString *assetIdentifier = nil;
    __weak typeof(self) weakSelf = self;
    //2.保存图片到系统相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //在系统相机胶卷中创建(即保存)一张带有本地标识的图片
        //获取保存的图片的标识
        assetIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [weakSelf showError:@"图片保存到相机胶卷失败!"];
            return;
        }
        //获取相册(可能是新建的)
        PHAssetCollection *myCollection = [weakSelf getAssetCollection];
        if (myCollection == nil) {
            [self showError:@"相册创建失败!"];
        }
        //4.保存图片到本应用相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //获取要保存的图片
            PHAsset *myAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetIdentifier] options:nil].lastObject;
            //将图片保存到相册中
            PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:myCollection];
            [collectionRequest addAssets:@[myAsset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == YES) {
                [weakSelf showSuccess:@"图片保存成功!"];
            }else {
                [weakSelf showError:@"图片保存失败!"];
                return;
            }
        }];
    }];
}
/**
 从系统相册中获取曾经创建过的相册
 @return nil或系统相册中已有的相册
 */
- (PHAssetCollection *)getAssetCollection {

    //返回已创建过的在系统相册中的相册
    PHFetchResult *createdCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *createdCollection in createdCollections) {
        if ([createdCollection.localizedTitle isEqualToString:MKBSBDJAlbumName]) {
            return createdCollection;
        }
    }
    //返回新的相册
    __block NSString *assetCollectionIdentifier = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{//同步创建,如果封装方法就用这个
        assetCollectionIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:MKBSBDJAlbumName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) return nil;
    PHAssetCollection *newColletion = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionIdentifier] options:nil].lastObject;
    return newColletion;
}
- (void)showSuccess:(NSString *)success {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:success];
    });
}
- (void)showError:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:error];
    });
}

- (IBAction)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UIScrollViewDelegate>
/**
 返回一个可缩放的视图

 @param scrollView self.scrollView
 @return self.imageView
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return self.imageView;
}

#pragma mark - 隐藏手机状态栏
- (BOOL)prefersStatusBarHidden {

    return YES;
}
@end
