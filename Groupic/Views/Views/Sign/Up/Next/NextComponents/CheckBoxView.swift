//
//  CheckBox.swift
//  Groupic
//
//  Created by Anatolij Travkin on 18.04.22.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(.white)
            //.foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}
