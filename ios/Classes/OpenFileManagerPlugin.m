#import "OpenFileManagerPlugin.h"
#if __has_include(<open_file_manager/open_file_manager-Swift.h>)
#import <open_file_manager/open_file_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "open_file_manager-Swift.h"
#endif

@implementation OpenFileManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpenFileManagerPlugin registerWithRegistrar:registrar];
}
@end
