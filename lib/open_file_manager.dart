library;

import 'open_file_manager.dart';
import 'src/open_file_manager_platform_interface.dart';

export 'src/config.dart';

Future<bool> openFileManager({
  AndroidConfig? androidConfig,
  IosConfig? iosConfig,
}) {
  return OpenFileManagerPlatform.instance.openFileManager(
    androidConfig: androidConfig,
    iosConfig: iosConfig,
  );
}
