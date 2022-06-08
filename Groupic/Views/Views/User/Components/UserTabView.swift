//
//  UserTabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.03.22.
//

import SwiftUI

struct UserTabView: View {
    var user: UserModel
    
    @Binding var next: Bool
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Spacer()
                
                Text(user.username)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Spacer()
            }.padding(.top, 50)
            
            HStack() {
                Button(action: {
                    self.next.toggle()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 20)
        }
    }
}

