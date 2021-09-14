import Flutter
import UIKit
import GoogleMaps
import CoreLocation


class FLNativeView: NSObject, FlutterPlatformView {
    
    
    let controller : MapViewController = MapViewController()
  
    private var _view: UIView
    private var eventSink: FlutterEventSink? = nil
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        GMSServices.provideAPIKey("AIzaSyDbTLcODdd9senLY6EkTs55lGK0Av9lx_4")
        controller.methodChannel = FlutterMethodChannel(name: "low_calories_google_map", binaryMessenger: messenger!);
        
       
    
//        eventSink = FlutterEventChannel(name: "low_calories_google_map", binaryMessenger:  messenger!)
//        .setStreamHandler(self.stream)
        
        super.init();

        
        let initParam = args as! NSDictionary
        controller.addMapStyle(initParam)
        
        controller.methodChannel!.setMethodCallHandler(self.handle)
        createNativeView(view: _view)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
        
        if controller.initResult == nil{
           controller.initResult = result
        }
        
      switch call.method {
        case "mapStyle":
            controller.addMapStyle(call.arguments as? NSDictionary,result)
        case "animatePolyLine":
            controller.animatePolyLine(call,result)
      case "addMarker":
            controller.addMarkerBase64(call.arguments as? NSDictionary,result)
      case "updateMarker":
            controller.updateMarker(call.arguments as? NSDictionary,result)
        default:
            print("default ")
      }
    }
    // updateMarker

    func view() -> UIView {
        return controller.mapView
    }
    
    
    func createNativeView(view _view: UIView){
        _view.addSubview(controller.mapView)
    }
    
    
    private func isNil(_ args : Any?) -> Bool { return args == nil }
    
    private func isNSDictionary(_ args:Any?) -> Bool {
        return args is NSDictionary
    }
    private func isNSArray(_ args:Any?) -> Bool {
        return args is NSArray
    }
    private func isBool(_ args:Any?) -> Bool {
        return args is Bool
    }
    
}

