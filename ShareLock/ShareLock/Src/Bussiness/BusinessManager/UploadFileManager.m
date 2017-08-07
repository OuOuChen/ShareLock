//
//  UploadFileManager.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/13.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "UploadFileManager.h"
#import "RequestManager.h"

@implementation UploadFileManager

- (void)uploadImage:(UIImage *)image
           progress:(void (^)(double))progress
            success:(void (^)(NSDictionary *dict))success
            failure:(void(^)())failure{
    
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    //大于100K进行压缩图片
    if (data.length>100*1024) {
        
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    
    [RequestManager postUploadWithUrl:[NSString stringWithFormat:@"%@%@",kSystemConfigModel.networkConfig.baseURL,kSystemConfigModel.networkConfig.path.loginUrl] fileData:data name:@"image" fileName:@"gauge.png" fileType:@"image/png" progress:^(double uploadProgress){
        progress(uploadProgress);
    } success:^(id responseObject) {
        success(responseObject);
    } fail:^{
        failure();
    }];
    
    
}

@end
