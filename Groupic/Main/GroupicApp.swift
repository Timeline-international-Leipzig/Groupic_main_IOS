//
//  GroupicApp.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27/09/2021.
//

import SwiftUI
import Firebase

@main
struct GroupicApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        // override apple's buggy alerts tintColor
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(named: "AccentColor")
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore())
                .environmentObject(NavigationLinkModel())
                .environmentObject(NavigationLinkModel2())
                .environmentObject(NavigationLinkModel3())
                .preferredColorScheme(.dark)
        }
    }
}
