//
//  FLNativeViewFactory.swift
//  low_calories_google_map
//
//  Created by Abdo on 29/08/2021.
//

import Foundation


class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    
    private var messenger: FlutterBinaryMessenger

    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
              return FlutterStandardMessageCodec.sharedInstance()
    }
}

