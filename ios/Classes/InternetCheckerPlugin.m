#import "InternetCheckerPlugin.h"
#if __has_include(<internet_checker/internet_checker-Swift.h>)
#import <internet_checker/internet_checker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "internet_checker-Swift.h"
#endif

@implementation InternetCheckerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInternetCheckerPlugin registerWithRegistrar:registrar];
}
@end
