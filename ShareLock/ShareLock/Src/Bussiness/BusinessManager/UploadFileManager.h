//
//  UploadFileManager.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/13.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFileManager : NSObject

/**
 上传图片
 
 @param image 要上传的图片
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)uploadImage:(UIImage *)image
           progress:(void (^)(double))progress
            success:(void (^)(NSDictionary *dict))success
            failure:(void(^)())failure;


@end
