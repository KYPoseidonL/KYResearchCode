//
//  UIImage+Scale.m
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage*)imageScaledWithImage:(UIImage*)image {

    if (!image) {
        
        return nil;
    }
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if (width > 1024 && height > 1024) {
        
        if (width > height) {
            
          image = [self imageWithImage:image scaledToSize:CGSizeMake(1024.f,1024.f * height / width)];
            
        }else {
        
          image =  [self imageWithImage:image scaledToSize:CGSizeMake(1024.f * width / height, 1024.f)];
        }
    }else if(width > 1024.f && height < 1024.f) {
    
        image = [self imageWithImage:image scaledToSize:CGSizeMake(1024.f,1024.f * height / width)];
    }else if(width < 1024.f && height > 1024.f) {
    
        image =  [self imageWithImage:image scaledToSize:CGSizeMake(1024.f * width / height, 1024.f)];
    }else {
    
        image = image;
    }
    return image;
}
+ (UIImage*)emojiImageScaledWithImage:(UIImage*)image {

    if (!image) {
        
        return nil;
    }
    
    image = [self imageWithImage:image scaledToSize:CGSizeMake(30.f,30.f)];

    return image;
}
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {

    UIGraphicsBeginImageContext(newSize);

    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)snapshotView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
