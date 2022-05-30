//
//  DropDownMenuView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.01.22.
//

import SwiftUI

struct DropDownMenu: View {
    @Binding var showingActionsSheet: Bool
    @Binding var showingActionsSheetEventNameChange: Bool
    @Binding var changeEventMode: Bool
    @Binding var deleteEvent: Bool
    
    var body: some View {
        Menu {
            Button {
                self.showingActionsSheetEventNameChange.toggle()
            } label: {
                Text("Titel bearbeiten")
            }
            Button {
                self.showingActionsSheet.toggle()
            } label: {
                Text("Coverbild bearbeiten")
            }
            Button {
                self.changeEventMode.toggle()
            } label: {
                Text("Ereignismodus ändern")
            }
            Button {
                self.deleteEvent.toggle()
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
