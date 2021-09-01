#import "LowCaloriesGoogleMapPlugin.h"
#if __has_include(<low_calories_google_map/low_calories_google_map-Swift.h>)
#import <low_calories_google_map/low_calories_google_map-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "low_calories_google_map-Swift.h"
#endif

@implementation LowCaloriesGoogleMapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLowCaloriesGoogleMapPlugin registerWithRegistrar:registrar];
}
@end
