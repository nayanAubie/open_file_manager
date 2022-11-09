import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'open_file_manager_platform_interface.dart';

/// An implementation of [OpenFileManagerPlatform] that uses method channels.
class MethodChannelOpenFileManager extends OpenFileManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('open_file_manager');

  @override
  Future<bool> openFileManager() async {
    final version = await methodChannel.invokeMethod<bool?>('openFileManager');
    return version ?? false;
  }
}
