//
//  LocationUpdate.swift
//  low_calories_google_map
//
//  Created by Abdo on 27/09/2021.
//

import Foundation
import Flutter
import UIKit
import GoogleMaps
import CoreLocation


class LocationUpdate : NSObject, CLLocationManagerDelegate ,FlutterStreamHandler{
    
    
    let location : Location = Location()

    
    override init(){
        super.init()
        location.locationManager.delegate = self
    }
    
    
    
    // heading --------- obj
    private var eventSink: FlutterEventSink? = nil
    var locationUpdateChannel : FlutterEventChannel!
    

    

    func startLocationUpdate(_ result:FlutterResult){
        location.getLocation(nil);
        locationUpdateChannel.setStreamHandler(self)
        result(true)
    }
    
    func stopLocationUpdate(_ result:FlutterResult){
        location.locationManager.stopUpdatingLocation();
        result(true)
    }
    
    // FlutterChannel --------- onCancel
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        location.locationManager.stopUpdatingLocation();
        eventSink = nil
        print("FlutterChannel --------- stopUpdatingLocation")
        return nil
    }
    
    
    
    // FlutterChannel --------- onListen
    public func onListen(withArguments arguments: Any?,eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        location.locationManager.startUpdatingLocation()
        print("FlutterChannel --------- startUpdatingLocation")
        return nil
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        print("location update = \(userLocation.coordinate.latitude)   ::::  \(userLocation.coordinate.longitude)")
        if(eventSink != nil){
            self.eventSink!([userLocation.coordinate.latitude,userLocation.coordinate.longitude])
        }
    }


}
