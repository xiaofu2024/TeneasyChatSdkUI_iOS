//
//  UIImage+GIF.h
//  ProgramIOS
//
//  Created by 韩寒 on 2021/7/19.
//

#import <UIKit/UIKit.h>


typedef void (^GIFimageBlock)(UIImage * _Nullable GIFImage);

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GIF)

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;

@end

NS_ASSUME_NONNULL_END
