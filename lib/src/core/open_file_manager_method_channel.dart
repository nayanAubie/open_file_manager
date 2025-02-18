import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../open_file_manager.dart';
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
    final arguments = <String, dynamic>{};
    if (Platform.isAndroid) {
      final folderType =
          androidConfig?.folderType ?? AndroidFolderType.download;
      arguments['folderType'] = folderType.name;
      if (folderType == AndroidFolderType.other) {
        assert(
          androidConfig?.folderPath?.isNotEmpty ?? false,
          'Folder path cannot be empty for "other" folder type',
        );
        arguments['folderPath'] = androidConfig!.folderPath;
      }
    } else if (Platform.isIOS) {
      arguments['folderPath'] = iosConfig?.folderPath;
    }
    final result = await methodChannel.invokeMethod<bool?>(
      'openFileManager',
      arguments,
    );
    return result ?? false;
  }
}
