import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'open_file_manager.dart';
import 'open_file_manager_method_channel.dart';

abstract class OpenFileManagerPlatform extends PlatformInterface {
  /// Constructs a OpenFileManagerPlatform.
  OpenFileManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static OpenFileManagerPlatform _instance = MethodChannelOpenFileManager();

  /// The default instance of [OpenFileManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelOpenFileManager].
  static OpenFileManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OpenFileManagerPlatform] when
  /// they register themselves.
  static set instance(OpenFileManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> openFileManager({
    AndroidConfig? androidConfig,
    IosConfig? iosConfig,
  }) {
    throw UnimplementedError('openFileManager() has not been implemented.');
  }
}
