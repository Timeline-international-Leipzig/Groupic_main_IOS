//
//  RadioGroupView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 07.03.22.
//

import SwiftUI
import RadioGroup

struct RadioGroupView: View {
    
    @State var selection: Int;
    
    var body: some View {
        
        VStack(alignment: .leading) {
        RadioGroupPicker(
            selectedIndex: $selection,
            titles: ["Teilnehmer", "Teilnehmer und deren Kontakte", "Jeder"])
                .spacing(20)
        }
    }
}

