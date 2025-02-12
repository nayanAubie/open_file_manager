library;

import 'open_file_manager.dart';
import 'src/open_file_manager_platform_interface.dart';

export 'src/config.dart';

/// Opens the default file manager app.
Future<bool> openFileManager({
  /// Configuration for Android platform
  AndroidConfig? androidConfig,

  /// Configuration for iOS platform
  IosConfig? iosConfig,
}) {
  return OpenFileManagerPlatform.instance.openFileManager(
    androidConfig: androidConfig,
    iosConfig: iosConfig,
  );
}
