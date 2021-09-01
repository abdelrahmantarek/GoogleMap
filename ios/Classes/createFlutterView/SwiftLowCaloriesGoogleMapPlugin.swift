import Flutter
import UIKit
import GoogleMaps


public class SwiftLowCaloriesGoogleMapPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let factory = FLNativeViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "<platform-view-type>")
  }
}

