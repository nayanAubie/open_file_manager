library open_file_manager;

import 'open_file_manager_platform_interface.dart';

part 'config.dart';

Future<bool> openFileManager({
  AndroidConfig? androidConfig,
  IosConfig? iosConfig,
}) {
  return OpenFileManagerPlatform.instance.openFileManager(
    androidConfig: androidConfig,
    iosConfig: iosConfig,
  );
}
