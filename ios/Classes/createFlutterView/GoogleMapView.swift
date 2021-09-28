import Flutter
import UIKit
import GoogleMaps
import CoreLocation


class FLNativeView: NSObject, FlutterPlatformView,GMSMapViewDelegate {
    
    
    let controller : MapViewController = MapViewController()
    let headingUpdate : HeadingUpdate = HeadingUpdate()
    let locationUpdate : LocationUpdate = LocationUpdate()
    let location : Location = Location()
    let polyLine : PolyLine = PolyLine()
    
    
    
    private var _view: UIView
    private var mapLoaded : Bool = false

    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()

        controller.methodChannel = FlutterMethodChannel(name: "plugins.flutter.io/google_maps_\(viewId)", binaryMessenger: messenger!);
        
       
    

        headingUpdate.headingChannel = FlutterEventChannel(name: "low_calories_google_map/headingUpdate_\(viewId)",binaryMessenger:  messenger!)
        locationUpdate.locationUpdateChannel = FlutterEventChannel(name: "low_calories_google_map/locationUpdate_\(viewId)",binaryMessenger:  messenger!)
  
        
        super.init();

        
        let initParam = args as! NSDictionary
        controller.addMapStyle(initParam)
        
        controller.methodChannel!.setMethodCallHandler(self.handle)
        createNativeView(view: _view)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
      switch call.method {
        case "mapStyle":
            controller.addMapStyle(call.arguments as? NSDictionary,result)
            break;
        case "animatePolyLine":
            controller.animatePolyLine(call,result)
            break;
      case "addPolyLine":
            polyLine.addPolyLine(call.arguments as? NSDictionary,result,controller.mapView)
          break;
      case "addMarker":
            controller.addMarkerBase64(call.arguments as? NSDictionary,result)
        break;
      case "updateMarker":
            controller.updateMarker(call.arguments as? NSDictionary,result)
        break;
      case "markerExist":
            controller.markerExist(call.arguments as? NSDictionary,result)
        break;
      case "animateToMap":
            controller.animateToMap(call.arguments as? NSDictionary,result)
        break;
      case "paddingMap":
            controller.paddingMap(call.arguments as? NSDictionary,result)
        break;
      case "getLocation":
        location.getLocation(result)
        break;
      case "locationStatusIos":
        location.getLocationStatusPermission(result)
        break;
      case "requestLocationPermissionIos":
        location.requestLocationPermission(result)
        break;
      case "checkGpsIos":
        location.getLocationStatus(result)
        break;
      case "requestOpenGpsIos":
        location.requestOpenGps(result)
        break;
      case "startHeadingUpdate":
        headingUpdate.startHeadingUpdate(result)
        break;
      case "stopHeadingUpdate":
        headingUpdate.stopHeadingUpdate(result)
        break;
      case "startLocationUpdate":
        locationUpdate.startLocationUpdate(result)
        break;
      case "stopLocationUpdate":
        locationUpdate.stopLocationUpdate(result)
        break;
        default:
            print("default ")
      }
    }
    //

    func view() -> UIView {
        return controller.mapView
    }
    
    
    func createNativeView(view _view: UIView){
        _view.addSubview(controller.mapView)
        controller.mapView.delegate = self
    }
        
    
    // MARK: GMSMapViewDelegate

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        if mapLoaded == false{
            self.onMapReady()
        }
    }
    
    
    func onMapReady(){
        print("map is Ready")
        mapLoaded = true
        controller.methodChannel?.invokeMethod("onMapCreate", arguments: true)
    }
 
   

    
}

