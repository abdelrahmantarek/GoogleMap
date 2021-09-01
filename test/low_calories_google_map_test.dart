import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';

void main() {
  const MethodChannel channel = MethodChannel('low_calories_google_map');

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
    expect(await LowCaloriesGoogleMap.platformVersion, '42');
  });
}
