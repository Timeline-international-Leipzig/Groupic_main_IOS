//
//  ProfileSettingsViewTabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.04.22.
//

import SwiftUI

struct ProfileSettingsViewTabView: View {
    @Binding var back: Bool
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Spacer()
                
                Text("Profil bearbeiten")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(alignment: .center)
                
                Spacer()
            }
            .padding()
            .background(Color("AccentColor"))
            
            HStack {
                Button(action: {
                    self.back.toggle()
                },
                label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                })
                
                Spacer()
            }
            .padding()
        }
    }
}


