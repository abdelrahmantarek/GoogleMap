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
    
    
    
    var methodChannel: FlutterMethodChannel?
    var initResult:FlutterResult? = nil
    let camera = GMSCameraPosition.camera(withLatitude: 10.7915928, longitude: 106.6692043, zoom: 16.0)
    lazy var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    var animatePolyline: AnimatePolyline?
    var lm:CLLocationManager!

    
    // Cannot convert value of type 'Any?' to expected argument type 'String'
    // Consecutive statements on a line must be separated by ';'

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
    }
    
    
    
    
    func animatePolyLine(_ call: FlutterMethodCall,_ result:FlutterResult){
        makeAnimatePolyline(route:getRoute(call) as [CLLocationCoordinate2D]);
        stepsCoords = (getRoute(call) as [CLLocationCoordinate2D]);
        addMarker(stepsCoords[0])
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
    
    var marker:GMSMarker?
    
    
    func addMarker(_ position: CLLocationCoordinate2D){
        self.marker = GMSMarker(position: position)
        self.marker!.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
        self.marker!.icon = self.createEndMaker()
        self.marker!.map = self.mapView
        self.playAnimation()
    }

    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    private func createEndMaker() -> UIImage {
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 15, height: 15), cornerRadius: 3)
        let innerRectanglePath = UIBezierPath(roundedRect: CGRect(x: 5.5, y: 5.5, width: 4, height: 4), cornerRadius: 0)
        return UIGraphicsImageRenderer(size: CGSize(width: 15, height: 15)).image { _ in
            rectanglePath.fill()
            UIColor.white.setFill()
            innerRectanglePath.fill()
        }
    }
    
    
    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {

        let fLat: Float = Float((fromLoc.latitude).degreesToRadians)
        let fLng: Float = Float((fromLoc.longitude).degreesToRadians)
        let tLat: Float = Float((toLoc.latitude).degreesToRadians)
        let tLng: Float = Float((toLoc.longitude).degreesToRadians)
        let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
        if degree >= 0 {
            return degree - 180.0
        }
        else {
            return (360 + degree) - 180
        }
    }
    
//    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {
//
//    let fLat: Float = Float((self.mapView.camera.target.latitude).degreesToRadians)
//    let fLng: Float = Float((self.mapView.camera.target.longitude).degreesToRadians)
//    let tLat: Float = Float((fromLoc.latitude).degreesToRadians)
//    let tLng: Float = Float((fromLoc.longitude).degreesToRadians)
//    let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
//    if degree >= 0 {
//         return degree
//    } else {
//         return 360 + degree
//     }
//    }
    
    var iPosition:Int = 0;
    var stepsCoords:[CLLocationCoordinate2D] = []
    var timer = Timer()
    
    func playAnimation(){
        
        lm = CLLocationManager()
        lm.delegate = self
        lm.startUpdatingHeading()
        
        
//        for position in self.stepsCoords.reversed(){
//            self.marker?.position = position
////                self.mapView.camera = GMSCameraPosition(target: position, zoom: 15, bearing: 0, viewingAngle: 0)
//            self.marker!.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
//            if self.iPosition != self.stepsCoords.count - 1 {
//                self.marker!.rotation = CLLocationDegrees(exactly: self.getHeadingForDirection(fromCoordinate: self.stepsCoords[self.iPosition], toCoordinate: self.stepsCoords[self.iPosition+1]))!
//            }
//
//        }
        
//        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
//
//            if self.iPosition == self.stepsCoords.count{
//                return;
//            }
//
//            print(self.iPosition);
//
//            let position = self.stepsCoords[self.iPosition]
//            self.marker?.position = position
////            self.marker!.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
//            if self.iPosition != self.stepsCoords.count - 1 {
//                self.marker!.rotation = CLLocationDegrees(exactly: self.getHeadingForDirection(fromCoordinate: self.stepsCoords[self.iPosition], toCoordinate: self.stepsCoords[self.iPosition+1]))!
//            }
//
//
//            self.iPosition += 1
//
//        })
        
        }
    
    
    private func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
            print("location manager :  ",newHeading.magneticHeading)
    }
    
    
    func addMarkerBase64(_ args: NSDictionary?,_ result:FlutterResult){
        let initParam = args!;
        let base64 = initParam["base64"] as? String ?? String("w");
        let image = convertBase64StringToImage(imageBase64String: base64)
        
        animateScaleMarker(image)
    }

    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }

    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }


    
    
    
    func animateScaleMarker(_ image :UIImage){
        let position = self.stepsCoords[10]
        let m = GMSMarker(position: position)
        
        //custom marker image
        let pulseRingImg = UIImageView(frame: CGRect(x: -30, y: -30, width: 78, height: 78))
        pulseRingImg.image = image
        pulseRingImg.isUserInteractionEnabled = false
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.5)
        
        //transform scale animation
        var theAnimation: CABasicAnimation?
        theAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        theAnimation?.repeatCount = Float.infinity
        theAnimation?.autoreverses = false
        theAnimation?.fromValue = Float(0.1)
        theAnimation?.toValue = Float(1.0)
        theAnimation?.isRemovedOnCompletion = false
        
        pulseRingImg.layer.add(theAnimation!, forKey: "pulse")
        pulseRingImg.isUserInteractionEnabled = false
        CATransaction.setCompletionBlock({() -> Void in
            
            //alpha Animation for the image
            let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.duration = 1.5
            animation.repeatCount = Float.infinity
            animation.values = [Float(1.0), Float(0.1)]
            m.iconView?.layer.add(animation, forKey: "opacity")
        })
        
        CATransaction.commit()
        m.iconView = pulseRingImg
        m.layer.addSublayer(pulseRingImg.layer)
        m.map = mapView
        m.groundAnchor = CGPoint(x: 0.5, y: 0.5)
    }
    
}
