import 'package:flutter_test/flutter_test.dart';
import 'package:open_file_manager/open_file_manager.dart';
import 'package:open_file_manager/open_file_manager_method_channel.dart';
import 'package:open_file_manager/open_file_manager_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOpenFileManagerPlatform
    with MockPlatformInterfaceMixin
    implements OpenFileManagerPlatform {
  @override
  Future<bool> openFileManager({
    AndroidConfig? androidConfig,
    IosConfig? iosConfig,
  }) =>
      Future.value(true);
}

void main() {
  final initialPlatform = OpenFileManagerPlatform.instance;

  test('$MethodChannelOpenFileManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOpenFileManager>());
  });

  test('getPlatformVersion', () async {
    final fakePlatform = MockOpenFileManagerPlatform();
    OpenFileManagerPlatform.instance = fakePlatform;

    expect(await openFileManager(), true);
  });
}
