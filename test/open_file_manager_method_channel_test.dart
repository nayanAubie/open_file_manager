import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_file_manager/open_file_manager_method_channel.dart';

void main() {
  MethodChannelOpenFileManager platform = MethodChannelOpenFileManager();
  const MethodChannel channel = MethodChannel('open_file_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.openFileManager(), '42');
  });
}
