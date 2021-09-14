//
//  MapViewController.swift
//  low_calories_google_map
//
//  Created by Abdo on 29/08/2021.
//


import Foundation
import Flutter
import UIKit
import GoogleMaps
import CoreLocation



class MapViewController: NSObject, CLLocationManagerDelegate{
    

    var stepsCoords:[CLLocationCoordinate2D] = []
    var methodChannel: FlutterMethodChannel?
    var initResult:FlutterResult? = nil
    let camera = GMSCameraPosition.camera(withLatitude: 10.7915928, longitude: 106.6692043, zoom: 16.0)
    lazy var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    var animatePolyline: AnimatePolyline?
    var lm:CLLocationManager!
    var  markers = [String: GMSMarker]()
   

    
    func addMapStyle(_ args: NSDictionary?,_ result:FlutterResult? = nil) {
        do {
            let initParam = args!;
            let mapStyle = initParam["mapStyle"] as? String ?? String("w");
            mapView.mapStyle = try GMSMapStyle(jsonString: mapStyle);
            if(result != nil){
                result!(true)
            }
        } catch {
            if(result != nil){
                result!(false)
            }
          NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    

    
    public func makeAnimatePolyline(route: [CLLocationCoordinate2D]) {
        print("starting draw poly line")
        animatePolyline = AnimatePolyline(mapView: mapView)
        animatePolyline?.route = route
        animatePolyline?.startAnimation()
        mapView.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: route.path), withPadding: 50.0))
        
        self.playAnimation()
    }
    
    
    
    
    func animatePolyLine(_ call: FlutterMethodCall,_ result:FlutterResult){
        makeAnimatePolyline(route:getRoute(call) as [CLLocationCoordinate2D]);
        stepsCoords = (getRoute(call) as [CLLocationCoordinate2D]);
    }
    

    
    func getRoute(_ call: FlutterMethodCall) -> [CLLocationCoordinate2D] {
        var listLatLngs : [CLLocationCoordinate2D] = [];
        let list = ((call.arguments as! NSArray)[0] as! NSArray);
        for latLng in list{
            let sss = latLng as! NSArray;
            let lat =  sss[0] as! CLLocationDegrees;
            let lng =  sss[1] as! CLLocationDegrees;
            let location = CLLocationCoordinate2D(latitude: lat, longitude:lng);
            listLatLngs.append(location)
        }
        return listLatLngs;
    }
    
    
    
    
    // animate marker ---------
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("location manager :  ",newHeading.magneticHeading)
    }
  

    
    func playAnimation(){
        lm = CLLocationManager()
        lm.delegate = self
        lm.startUpdatingHeading()
    }
    
    
    private func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
            print("location manager :  ",newHeading.magneticHeading)
    }
    
    
    func addMarkerBase64(_ args: NSDictionary?,_ result:FlutterResult){
        let initParam = args!;
        let base64 = initParam["base64"] as? String ?? String("w");
        let image = convertBase64StringToImage(imageBase64String: base64)
        
        animateScaleMarker(image,args)
    }

    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }



    func animateScaleMarker(_ image :UIImage,_ args: NSDictionary?){
    
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                        width: args?.value(forKey: "size.width") as! Double,
                        height: args?.value(forKey: "size.height") as! Double
        ))
        imageView.image = image
        imageView.contentMode = .center
        let pulseMarker = GMSMarker(position: CLLocationCoordinate2D(
                      latitude: args?.value(forKey: "position.lat") as! Double,
                      longitude: args?.value(forKey: "position.lng") as! Double
        ))
        if args?.object(forKey: "scale.duration") != nil {
            CATransaction.setCompletionBlock {() -> Void in
                //alpha Animation for the image
                print(args?.value(forKey: "scale.autoReverses") as! Bool)
                let animation = CABasicAnimation(keyPath: "transform.scale.xy")
                animation.repeatCount = Float.infinity
                animation.duration = args?.value(forKey: "scale.duration") as! Double
                animation.fromValue = args?.value(forKey: "scale.fromValue") as! Double
                animation.toValue = args?.value(forKey: "scale.toValue") as! Double
                animation.isRemovedOnCompletion = false
                animation.autoreverses = args?.value(forKey: "scale.autoReverses") as! Bool
                pulseMarker.iconView?.layer.add(animation, forKey: "pulse")
            }
        }
        if args?.object(forKey: "heading") != nil {
            pulseMarker.rotation = args?.value(forKey: "heading") as! Double;
        }
        if args?.object(forKey: "isFlat") != nil {
            pulseMarker.isFlat = args?.value(forKey: "isFlat") as! Bool;
        }
        pulseMarker.iconView = imageView
        pulseMarker.opacity = args?.value(forKey: "opacity") as! Float
        pulseMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        pulseMarker.map = mapView
        
        markers[args?.value(forKey: "id") as! String] = pulseMarker
    }
    
    
    
    func updateMarker(_ args: NSDictionary?,_ result:FlutterResult){
        let marker = markers[args?.value(forKey: "id") as! String]
        marker?.rotation = args?.value(forKey: "heading") as! Double;
        if args?.object(forKey: "isFlat") != nil {
            marker?.isFlat = args?.value(forKey: "isFlat") as! Bool;
        }
        marker?.position = CLLocationCoordinate2D(
            latitude: args?.value(forKey: "position.lat") as! Double,
            longitude: args?.value(forKey: "position.lng") as! Double
        );
    }
    
    
   func addImageMarker(_ image :UIImage){
        let position = self.stepsCoords[10]
        let m = GMSMarker(position: position)
        //custom marker image
        let pulseRingImg = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        pulseRingImg.image = image
        m.iconView = pulseRingImg
        m.layer.addSublayer(pulseRingImg.layer)
        m.map = mapView
        m.groundAnchor = CGPoint(x: 0.5, y: 0.5)
    }
    
  
}


