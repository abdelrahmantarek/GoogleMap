//
//  HeadingUpdate.swift
//  low_calories_google_map
//
//  Created by Abdo on 27/09/2021.
//

import Foundation
import Foundation
import Flutter
import UIKit
import GoogleMaps
import CoreLocation



class HeadingUpdate : NSObject, CLLocationManagerDelegate ,FlutterStreamHandler{
    
    
    var locationManager:CLLocationManager = CLLocationManager()
    

    override init(){
        super.init()
        locationManager.delegate = self
    }

    
    
    // heading --------- obj
    private var eventSink: FlutterEventSink? = nil

    
    // heading ---------- start update
    func startHeadingUpdate(_ result:FlutterResult){
        headingChannel.setStreamHandler(self)
        result(true)
    }
    
    // heading ---------- stop update
    func stopHeadingUpdate(_ result:FlutterResult){
        locationManager.stopUpdatingHeading()
        result(true)
    }

    // heading --------- listener
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("location manager :  ",newHeading.magneticHeading)
        if(eventSink != nil){
            self.eventSink!(newHeading.magneticHeading)
        }
    }
   
    
    
    
    var headingChannel : FlutterEventChannel!
    
    // FlutterChannel --------- onCancel
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationManager.stopUpdatingHeading();
        eventSink = nil
        print("FlutterChannel --------- onCancel")
        return nil
    }
    
    
    
    // FlutterChannel --------- onListen
    public func onListen(withArguments arguments: Any?,eventSink: @escaping FlutterEventSink) -> FlutterError? {
        locationManager.startUpdatingHeading();
        self.eventSink = eventSink
        print("FlutterChannel --------- onListen")
        return nil
    }
    
}
