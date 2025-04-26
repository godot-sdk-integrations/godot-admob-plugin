//
// © 2024-present https://github.com/cengiz-pz
//

#ifndef ad_format_base_h
#define ad_format_base_h

#import "gap_converter.h"
#import "view_controller.h"
#import "app_delegate.h"

@import GoogleMobileAds;

@interface AdFormatBase : ViewController 

@property (nonatomic,strong) NSString* adId;

@property (class) BOOL pauseOnBackground;

@end

#endif /* ad_format_base_h */
