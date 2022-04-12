//
//  DropDownMenuView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.01.22.
//

import SwiftUI

struct DropDownMenu: View {
    var body: some View {
        
        Menu {
            Button {
            } label: {
                Text("Titel bearbeiten")
            }
            Button {
            } label: {
                Text("Coverbild bearbeiten")
            }
            Button {
            } label: {
                Text("Ereignismodus ändern")
            }
            Button {
            } label: {
                Text("Ereignis verlassen")
            }
        } label: {
            Image(systemName: "line.horizontal.3")
                .foregroundColor(.black)
                .font(.system(size: 20))

            
        }
    }
}
