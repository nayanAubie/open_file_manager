/// Configuration class for Android platform.
final class AndroidConfig {
  /// Type of folder to open.
  final FolderType folderType;

  AndroidConfig({required this.folderType});
}

/// Configuration class for iOS platform.
final class IosConfig {
  /// Sub folder path to open.
  final String subFolderPath;

  IosConfig({required this.subFolderPath});
}

/// Available folder types for Android.
enum FolderType {
  /// Recent folder
  recent,

  /// Download folder
  download
}
