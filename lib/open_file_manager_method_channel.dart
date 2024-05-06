import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'open_file_manager.dart';
import 'open_file_manager_platform_interface.dart';

/// An implementation of [OpenFileManagerPlatform] that uses method channels.
class MethodChannelOpenFileManager extends OpenFileManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('open_file_manager');

  @override
  Future<bool> openFileManager({
    AndroidConfig? androidConfig,
    IosConfig? iosConfig,
  }) async {
    final data = <String, dynamic>{};
    if (Platform.isAndroid && androidConfig != null) {
      data['folderType'] = androidConfig.folderType.name;
    } else if (Platform.isIOS && iosConfig != null) {
      data['subFolderPath'] = iosConfig.subFolderPath;
    }
    final version =
        await methodChannel.invokeMethod<bool?>('openFileManager', data);
    return version ?? false;
  }
}
