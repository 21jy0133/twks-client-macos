//
//  twksApp.swift
//  twks-client-macos
//
//

import SwiftUI

import SocketIO


@main
struct twksApp: App {
    
    @StateObject var userState = UserState()
    
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8000/")!, config: [.log(true), .compress])
    
    init() {
        
        
        // let socket = manager.defaultSocket
        
        // let globalQueue = DispatchQueue.global()
        
        
        // socket.connect(withPayload: dict)
        
        
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        //let accessEnabled = AXIsProcessTrustedWithOptions(options)
        
        print("AXIsProcessTrusted:",AXIsProcessTrustedWithOptions(options))
        
        /*
         NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> Void in
         
         // let toPos = CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
         
         
         // let jsonData = try JSONSerialization.data(withJSONObject: event, options: .prettyPrinted)
         let dic = ["type": "mouseMoved", "data": String(describing:event)]
         socket.emit("event", dic)
         
         
         })
         */
        
        
        
        let item1 = DispatchWorkItem {
            NSEvent.addGlobalMonitorForEvents(matching: [.keyDown,.keyUp, .leftMouseDown], handler: {(event: NSEvent) -> Void in
                print("Key Down >>>", (event))
            })
        }
        
        //
        
        //
        
        
        //globalQueue.async(execute: item1)
        
        
        
        /*
         NSEvent.addGlobalMonitorForEvents(matching: [.keyDown,.keyUp, .leftMouseDown], handler: {(event: NSEvent) -> Void in
         print("Key Down >>>", (event))
         })
         
         */
        
        
    }
    @SceneBuilder var body: some Scene {
        WindowGroup {
            
            if userState.isLoginedIn {
                MainView().environmentObject(userState)
            } else {
                LoginView().environmentObject(userState)
            }
        
        }
    }
}
