//
//  DM_ADModel.h
///  DMAd
//
//  Created by 刘士林 on 2024/3/14.
//

#import <Foundation/Foundation.h>

@class NewTargetOption;

@interface DM_ADModel : NSObject
/**
 广告资源的链接
 */
@property (nonatomic,copy) NSString *picture_url;
/**
 大小
 */
@property (nonatomic,assign) CGSize adSize;
/**
 打开外部应用
 */
@property (nonatomic,copy) NSString *universal_link;
/**
 appId
 */
@property (nonatomic,copy) NSString *appId;
/**
 点击广告打开落地页
 */
@property (nonatomic,copy) NSString *link_url;
/**
 微信小程序
 */
@property (nonatomic,copy) NSString *wxId;
/**
 标题
 */
@property (nonatomic,copy) NSString *title;
/**
 app名字
 */
@property (nonatomic,copy) NSString *appName;
/**
 app图片
 */
@property (nonatomic,copy) NSString *appImage;
/**
 上报地址-不喜欢
 */
@property (nonatomic,copy) NSArray *eventTrackUrl;
/**
 打开u-link的上报
 */
@property (nonatomic,copy) NSArray *eventDeeplinkUrlArr;
/**
 点击上报
 */
@property (nonatomic,copy) NSArray *clickTrackingURL;
/**
 检测上报,在显示的时候调用
 */
@property (nonatomic,copy) NSArray *impressionTrackingURLArray;

/** 视频缩略图 */
@property (nonatomic,copy) NSString *videoCover;

/** 视频素材地址 */
@property (nonatomic,copy) NSString *videoURL;

/** 广告描述 */
@property (nonatomic,copy) NSString *description_p;
/** 缓存到本地的视频地址 */
@property (nonatomic,strong) NSURL *localVideoURL;
/** 按钮的文字 */
@property (nonatomic,copy) NSString *adWords;
/** 陀螺仪的灵敏度 0 是隐藏 */
@property (nonatomic,copy) NSString * sensitivity;
//控制点击关闭按钮时候的弹窗
@property (nonatomic, assign) bool isHidden;
//dspId
@property (nonatomic, assign) int dspId;
/** 素材尺寸宽度 */
@property(nonatomic, assign) int32_t width;

/** 素材尺寸高度 */
@property(nonatomic, assign) int32_t height;

/** 视频时长，单位毫秒 */
@property(nonatomic, assign) int32_t videoDuration;

@property(nonatomic, strong) NewTargetOption * option;

/** 开始播放上报URL */
@property (nonatomic, copy) NSArray *eventTrackStartUrl;
/** 暂停播放上报URL */
@property (nonatomic, copy) NSArray *eventTrackPauseUrl;

@end
