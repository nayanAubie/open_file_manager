final class AndroidConfig {
  final FolderType folderType;

  AndroidConfig({required this.folderType});
}

final class IosConfig {
  final String subFolderPath;

  IosConfig({required this.subFolderPath});
}

enum FolderType { recent, download }
