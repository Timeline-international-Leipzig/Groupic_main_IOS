//
//  SideMenu.swift
//  Groupic
//
//  Created by Johannes Busch on 12.06.22.
//

import SwiftUI

struct SideMenue: View {
    @EnvironmentObject var model: NavigationLinkModel2
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var next = false
    @State var next2 = false
    
    var body: some View {
        NavigationLink(destination: SettingsView(), isActive: $model.pushed, label: {
            EmptyView()
        })
        
        HStack(spacing: 0) {
            
            Spacer(minLength: 0)
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top, spacing: 12) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Button(action: {
                            self.model.pushed = true
                        }, label: {
                            Label("Einstellungen", systemImage: "gearshape.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                        }).padding(.leading, 20)
                            .padding(.top, 20)
                        
                        Divider()
                            .background(Color(.white))
                            .padding(.leading, 15)
                    }
                    
                    Spacer(minLength: 0)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom , edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Color("mainColor"))
            .ignoresSafeArea(.all, edges: .vertical)
        }
        .ignoresSafeArea()
    }
}
