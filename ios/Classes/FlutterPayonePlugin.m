#import "FlutterPayonePlugin.h"
#if __has_include(<comet_payone/comet_payone-Swift.h>)
#import <comet_payone/comet_payone-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "comet_payone-Swift.h"
#endif

@implementation FlutterPayonePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPayonePlugin registerWithRegistrar:registrar];
}
@end
