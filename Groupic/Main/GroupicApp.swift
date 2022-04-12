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
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}
