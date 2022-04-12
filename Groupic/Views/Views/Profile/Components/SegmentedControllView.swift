//
//  SegmentedControll.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.01.22.
//


/*
import SwiftUI

struct SegmentedControll: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .init(named: "AccentColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
    }
    
    @State private var selectedTab: Selecter = .alleEvents
    
    var body: some View {
        
        VStack{
            Spacer()
            Picker("Choose", selection: $selectedTab) {
                ForEach(Selecter.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            Spacer()
            SelectedView(selectedTab: selectedTab)
            Spacer()
        }
        .padding(.top, 20)
    }
}

enum Selecter: String, CaseIterable {
    case highlight = "Highlight"
    case alleEvents = "Alle Events"
    case anstehend = "Anstehend"
    case kontakte = "Kontakte"
}

struct SelectedView: View {
    
    var selectedTab: Selecter
    
    @State var next = false
    
    var body: some View {
        
        switch selectedTab {
        case .highlight:
            SocialView()
        case .alleEvents:
            UserPostView()
        case .anstehend:
            SocialView()
        case .kontakte:
            SocialView()
        }
        
    }
 }
 */
