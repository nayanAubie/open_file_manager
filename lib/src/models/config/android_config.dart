import 'android_folder_type.dart';

/// Configuration class for Android platform.
final class AndroidConfig {
  /// Type of folder to open. Default is [AndroidFolderType.download].
  final AndroidFolderType folderType;

  /// Required only for "Other" folder type.
  /// e.g. "Pictures/Screenshots"
  final String? folderPath;

  AndroidConfig({
    this.folderType = AndroidFolderType.download,
    this.folderPath,
  });
}
