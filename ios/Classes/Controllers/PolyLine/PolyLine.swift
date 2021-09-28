//
//  PolyLine.swift
//  low_calories_google_map
//
//  Created by Abdo on 28/09/2021.
//

import Foundation
import GoogleMaps


class PolyLine{
    
    lazy var mapView = GMSMapView.init()
    private lazy var currentSegment = GMSPolyline()
    private lazy var backgroundSegment = GMSPolyline()
    private var color = UIColor(rgb: 0xFFFFFF)
    private var totalSteps = 0
    private var displaylink: CADisplayLink?
    
    open var duration: TimeInterval = 3.0
    private var totalDuration = 0.0
    
    
    
    open var route: [CLLocationCoordinate2D] = [] {
        didSet {
            route.balance(with: 15.0)
            totalSteps = self.route.count
            updateOverlay()
        }
    }
    
  

    open func startAnimation() {
        currentSegment.path = route.path
        backgroundSegment.strokeColor = UIColor.black.withAlphaComponent(0.0)
        displaylink?.add(to: .current, forMode: RunLoop.Mode.default)
    }

    open func pauseAnimation() {
        displaylink?.remove(from: .current, forMode: RunLoop.Mode.default)
    }

    open func stopAnimation() {
        displaylink?.remove(from: .current, forMode: RunLoop.Mode.default)
        currentSegment.path = route.path
        backgroundSegment.strokeColor = .black
    }

    
    func getRoute(_ list: NSArray) -> [CLLocationCoordinate2D] {
        var listLatLngs : [CLLocationCoordinate2D] = [];
        for latLng in list{
            let sss = latLng as! NSArray;
            let lat =  sss[0] as! CLLocationDegrees;
            let lng =  sss[1] as! CLLocationDegrees;
            let location = CLLocationCoordinate2D(latitude: lat, longitude:lng);
            listLatLngs.append(location)
        }
        return listLatLngs;
    }

    
    private func updateOverlay() {
        currentSegment.path = route.path
        backgroundSegment.path = route.path
        backgroundSegment.strokeColor = color
    }
    
    
    func addPolyLine(_ args: NSDictionary?,_ result:FlutterResult,_ mapView:GMSMapView){
        self.mapView = mapView
        self.route = (self.getRoute((args!.value(forKey: "polyLine.points") as! NSArray)[0] as! NSArray) as [CLLocationCoordinate2D]);
        
        // color
        currentSegment.strokeColor = color
        backgroundSegment.strokeColor = color
        
        
        
        
        // path 1
        currentSegment = GMSPolyline(path: route.path)
        currentSegment.strokeWidth = 5.0
        currentSegment.strokeColor = color
        currentSegment.map = mapView

        
        // path 2
        backgroundSegment = GMSPolyline(path: route.path)
        backgroundSegment.strokeWidth = 5.0
        backgroundSegment.map = mapView
        
        
        
        
        displaylink = CADisplayLink(target: self, selector: #selector(step))
        
        startAnimation();
        
        result(true)
    }
    
    
    
    @objc private func step(displaylink: CADisplayLink) {
        let percentage = Float(totalDuration / duration)

        let timingStepValue: Float = Curve.cubic.easeOut(percentage)
        let nextStep: Int = Int(round(timingStepValue.convert(to: 1.0...Float(totalSteps))))

        let timingAlphaValue: Float = Curve.circular.easeIn(percentage)
        let nextAlpha: CGFloat = CGFloat(timingAlphaValue.convert(to: 0.3...1.0))

        // Animation step.
        currentSegment.path = route.suffix(from: nextStep).path
        backgroundSegment.strokeColor = color.withAlphaComponent(nextAlpha)

        totalDuration = totalDuration + displaylink.duration
        if totalDuration > duration {
            totalDuration = 0.0
        }
    }

}





fileprivate extension ArraySlice where Element == CLLocationCoordinate2D {
    var path: GMSPath {
        let path = GMSMutablePath()
        self.forEach { path.add($0) }
        return path
    }
}
