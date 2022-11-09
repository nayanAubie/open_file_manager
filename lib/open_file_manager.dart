import 'open_file_manager_platform_interface.dart';

Future<bool> openFileManager() {
  return OpenFileManagerPlatform.instance.openFileManager();
}
