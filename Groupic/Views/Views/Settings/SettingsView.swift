//
//  SettingsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 17.01.22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var model: NavigationLinkModel2
    @EnvironmentObject var model2: NavigationLinkModel
    
    @State var nextAGB = false
    @State var nextDatenschutz = false
    @State var nextSupport = false
    
    @State var nextProfile = false
    
    init() {
        UINavigationBar.appearance().tintColor = .white
        UIBarButtonItem.appearance().title = "HEllo"
    }
    
    var body: some View {
        NavigationLink(destination: ProfileSettingsView(session: self.session.session, back: $nextProfile), isActive: self.$nextProfile, label: {
            EmptyView()
        })
        
        NavigationLink(destination: AGBView(back: $nextAGB), isActive: self.$nextAGB, label: {
            EmptyView()
        })
        
        NavigationLink(destination: DatenschutzView(back: $nextDatenschutz), isActive: self.$nextDatenschutz, label: {
            EmptyView()
        })
        
        /*
         NavigationLink(destination: SupportView(back: $nextSupport), isActive: self.$nextSupport, label: {
         EmptyView()
         })
         */
        
        ZStack {
            
            VStack(alignment: .center, spacing: 0) {
                
                /*
                ZStack {
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        ).colorInvert()
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Einstellungen")
                            .font(.custom("Inter-Regular", size: 22))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .zIndex(1)
                    .padding(.top, 30)
                    
                    HStack {
                        Button(action: {
                            self.model.pushed = false
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                    }
                    .zIndex(1)
                    .padding(.top, 30)
                    .padding(.leading, 20)
                }
                 */
                
                Form {
                    Section(header: Text("Deine Einstellungen").font(.custom("Inter-Regular", size: 14))) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.gray)
                                
                                Image(systemName: "gear")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Profil bearbeiten")
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextProfile = true
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.gray))
                        }
                                                
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.gray)
                                
                                Image(systemName: "arrow.right.square")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Abmelden")
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.session.logout()
                                self.session.session = nil
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.gray))
                        }
                    }
                }.onAppear {UITableView.appearance().backgroundColor = .clear}
                
                Form {
                    Section(header: Text("Rechtliche Dokumente").font(.custom("Inter-Regular", size: 14))) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.gray)
                                
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Datenschutz")
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextDatenschutz.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.gray))
                        }
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.gray)
                                
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("AGB")
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextAGB.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.gray))
                        }
                    }
                }.offset(y: -100)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                        ).colorInvert()
                }
            }
            .background(Color("mainColor"))
            .navigationTitle("")
            .navigationBarTitle("")
        }
    }
}

