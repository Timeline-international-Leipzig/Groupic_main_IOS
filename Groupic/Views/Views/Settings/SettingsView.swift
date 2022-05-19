//
//  SettingsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 17.01.22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var next: Bool
    
    @State var nextAGB = false
    @State var nextDatenschutz = false
    @State var nextSupport = false
    
    @State var nextProfile = false
    
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
            
            VStack {
                
                ZStack {
                    
                    HStack {
                        
                        Button(action: {
                            self.next.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        .padding()
                        
                        Spacer()
                        
                    }.zIndex(1)
                    
                    Text("Einstellungen")
                        .padding(.top, 10)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                        .hCenter()
                        .zIndex(1)
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        ).colorInvert()
                }
                
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
            }.zIndex(1)
            
            VStack(alignment: .center, spacing: 0) {
                
                Form {
                    Group {
                        Section(header: Text("Deine Einstellungen").foregroundColor(.white)) {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color(.systemGray2))
                                    
                                    Image(systemName: "gear")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 36, height: 36, alignment: .center)
                                
                                Text("Profil bearbeiten")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                Button(action: {
                                    self.nextProfile.toggle()
                                }) {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                }
                                .accentColor(Color(.white))
                            }
                            
                            /*
                             HStack {
                             ZStack {
                             RoundedRectangle(cornerRadius: 8, style: .continuous)
                             .fill(Color.blue)
                             
                             Image(systemName: "person.fill")
                             .foregroundColor(.white)
                             }
                             .frame(width: 36, height: 36, alignment: .center)
                             
                             Text("Anwendungseinstellungen").padding(.horizontal)
                             
                             Spacer()
                             
                             Button(action: {
                             
                             }) {
                             Image(systemName: "chevron.right")
                             .font(.system(size: 14, weight: .semibold, design: .rounded))
                             }
                             .accentColor(Color(.systemGray2))
                             }
                             */
                            
                            /*
                             HStack {
                             ZStack {
                             RoundedRectangle(cornerRadius: 8, style: .continuous)
                             .fill(Color.yellow)
                             
                             Image(systemName: "envelope.fill")
                             .foregroundColor(.white)
                             }
                             .frame(width: 36, height: 36, alignment: .center)
                             
                             Text("Kontakt").padding(.horizontal)
                             
                             Spacer()
                             
                             Button(action: {
                             self.nextSupport.toggle()
                             }) {
                             Image(systemName: "chevron.right")
                             .font(.system(size: 14, weight: .semibold, design: .rounded))
                             }
                             .accentColor(Color(.systemGray2))
                             }
                             */
                            
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color(.systemGray2))
                                    
                                    Image(systemName: "arrow.right.square")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 36, height: 36, alignment: .center)
                                
                                Text("Abmelden")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                Button(action: {
                                    self.session.logout()
                                    self.session.session = nil
                                }) {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                }
                                .accentColor(Color(.white))
                            }
                        }
                    }.listRowBackground(Color("lightDark"))
                }.onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }.padding(.top, 80)
                
                Form {
                    Group {
                    Section(header: Text("Rechtliche Dokumente").foregroundColor(.white))
                    {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color(.systemGray2))
                                
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Datenschutz")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextDatenschutz.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.white))
                        }
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color(.systemGray2))
                                
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("AGB")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextAGB.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.white))
                        }
                    }
                }.listRowBackground(Color("lightDark"))
                }.onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }.offset(y:-150)
            }
            .background(Color("background"))
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }.ignoresSafeArea()
    }
}
