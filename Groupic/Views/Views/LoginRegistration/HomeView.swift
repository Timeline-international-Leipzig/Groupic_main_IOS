//
//  HomeView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27/09/2021.
//

import SwiftUI

struct HomeView: View {
    @State var viewState = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        NavigationView {
            VStack {
                if self.status {
                    ProfileView()
                }
                else {
                    ZStack {
                        NavigationLink(destination: RegistrationView(viewState: self.$viewState), isActive: self.$viewState, label: {
                            EmptyView()
                        })

                        LoginView(viewState: self.$viewState)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) {(_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}
