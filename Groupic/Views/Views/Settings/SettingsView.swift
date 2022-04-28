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
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
            
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    HStack(spacing: 15) {
                        Spacer()
                        
                        Text("Einstellungen")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(alignment: .center)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color("AccentColor"))
                    
                    HStack() {
                        Button(action: {
                            self.next.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                    }
                    .padding()
                }
                
                Form {
                    Section(header: Text("Deine Einstellungen")) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.gray)
                                
                                Image(systemName: "gear")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Profil bearbeiten").padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextProfile.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.systemGray2))
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
                                    .fill(Color.red)
                                
                                Image(systemName: "arrow.right.square")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Abmelden").padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.session.logout()
                                self.session.session = nil
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.systemGray2))
                        }
                    }
                }
                
                Form {
                    Section(header: Text("Rechtliche Dokumente")) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.orange)
                                
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Datenschutz").padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextDatenschutz.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.systemGray2))
                        }
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.green)
                                
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("AGB").padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.nextAGB.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            }
                            .accentColor(Color(.systemGray2))
                        }
                    }
                }
                .offset(y:-100)
            }
            .background(Color(.systemGray6))
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}
