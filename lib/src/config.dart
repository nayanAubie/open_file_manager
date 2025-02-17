/// Configuration class for Android platform.
final class AndroidConfig {
  /// Type of folder to open.
  final FolderType folderType;

  /// Folder path to open on folder type `other`
  final String? folderPath;

  AndroidConfig({required this.folderType, this.folderPath});
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
  download,

  /// Other folder
  other,
}
