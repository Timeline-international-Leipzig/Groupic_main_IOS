//
//  Test.swift
//  Groupic
//
//  Created by Anatolij Travkin on 15.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct UserPostCardView: View {
    @StateObject var profileService = ProfileService()
    
    @State var postModel: PostModel
    @State var userModel: UserModel
    @State var next = false
    
    @Binding var exist: Bool
    
    @State var existsAcc = false
    
    var userCollection = Firestore.firestore().collection("users")
    
    var body: some View {
        if exist == true && postModel.index == 0 {
            NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            //UserPostCard1
            VStack(spacing: 0) {
                HStack {
                    VStack(spacing: 0) {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                
                                Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.publishTime))
                                .timeAgo())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(.white)
                            .frame(alignment: .topLeading)
                        }
                    }
                    
                    Spacer()
                }.padding(.leading, 5)
                
                VStack {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            
                            WebImage(url: URL(string: postModel.coverPic)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 200, alignment: .center)
                                .clipped()
                        }
                    )
                    
                    HStack {
                        
                        ZStack {
                            HStack {
                                if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                }
                                
                                else {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                    
                                    Text("-")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                }
                            }.padding(.trailing, 10)
                            
                            HStack {
                                Color.white.frame(width:CGFloat(2) / UIScreen.main.scale)

                                Text(postModel.title)
                                    .font(.custom("Inter-Regular", size: 20))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }.padding(.leading, 10)
                        }
                    }
                }
            }
        }
        
        if exist == false && postModel.index == 0 {
            NavigationLink(destination: EventViewOnlyContactView(postModel: postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            //UserPostCard2
            VStack(spacing: 0) {
                HStack {
                    VStack(spacing: 0) {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                
                                Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.publishTime))
                                .timeAgo())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                } .padding(.leading, 5)
                
                VStack(spacing: 0) {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            
                            WebImage(url: URL(string: postModel.coverPic)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 200, alignment: .center)
                                .clipped()
                        }
                    )
                    
                    HStack {
                        
                        ZStack {
                            HStack {
                                if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                }
                                
                                else {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                    
                                    Text("-")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                }
                            }.padding(.trailing, 10)
                            
                            HStack {
                                Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)

                                Text(postModel.title)
                                    .font(.custom("Inter-Regular", size: 20))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }.padding(.leading, 10)
                        }
                    }
                }
            }
        }
        
        if exist == true && postModel.index == 1 {
            NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            //UserPostCard3
            VStack(spacing: 0) {
                HStack {
                    VStack(spacing: 0) {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                
                                Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.publishTime))
                                .timeAgo())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(.white)
                            .frame(alignment: .topLeading)
                            .offset(y: -5)
                        }
                    }
                    
                    Spacer()
                }.padding(.leading, 5)
                
                VStack {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            
                            WebImage(url: URL(string: postModel.coverPic)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 170, alignment: .center)
                                .clipped()
                        }
                    )
                    
                    HStack {
                        ZStack {
                            HStack {
                                if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                                
                                else {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(" - ")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                            }.padding(.trailing, 10)
                            
                            HStack {
                                Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)

                                Text(postModel.title)
                                    .foregroundColor(.white)
                                    .font(.custom("Inter-Regular", size: 20))
                                    .frame(width: 320, height: 40, alignment: .topLeading)
                                
                                Spacer()
                            }.padding(.leading, 10)
                        }
                    }
                }
            }
        }
        
        if postModel.index == 2 {
            VStack {
                ForEach(profileService.usersUid, id: \.uid) {
                    (userUid) in
                    
                    VStack {}
                    .onAppear {
                        checkIfUserExistsContacts(userId: Auth.auth().currentUser!.uid, participantId: userUid.uid) { result in
                            if (result == true) {
                                self.existsAcc = true
                                return
                            }
                            else {
                                self.existsAcc = false
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.profileService.loadAllEventUsers(postId: postModel.id)
                self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            }
            
            if postModel.index == 2 && existsAcc == true {
                NavigationLink(destination: EventViewOnlyContactView(postModel: postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                //UserPostCard4
                VStack(spacing: 0) {
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                    
                                    Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                                }
                                
                                Text((Date(timeIntervalSince1970: postModel.publishTime))
                                    .timeAgo())
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            }
                        }
                        
                        Spacer()
                    }.padding(.leading, 5)
                    
                    VStack {
                        Button(
                            action: {
                                self.next.toggle()
                            },
                            label: {
                                WebImage(url: URL(string: postModel.coverPic)!)
                                    .resizable()
                                    .frame(width: getRectView().width, height: 170, alignment: .center)
                                    .clipped()
                            }
                        )
                        
                        HStack {
                            ZStack {
                                HStack {
                                    if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                    }
                                    
                                    else {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(" - ")
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(postModel.endDate, style: .date)
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                    }
                                }.padding(.trailing, 10)
                                
                                HStack {
                                    Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)

                                    Text(postModel.title)
                                        .foregroundColor(.white)
                                        .font(.custom("Inter-Regular", size: 20))
                                        .frame(width: 320, height: 40, alignment: .topLeading)
                                    
                                    Spacer()
                                }.padding(.leading, 10)
                            }
                        }
                    }
                }
            }
            
            if exist == true && postModel.index == 2 {
                NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                //UserPostCard5
                VStack(spacing: 0) {
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                    
                                    Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                                }
                                
                                Text((Date(timeIntervalSince1970: postModel.publishTime))
                                    .timeAgo())
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            }
                        }
                
                        Spacer()
                    }.padding(.leading, 5)
                    
                    VStack {
                        Button(
                            action: {
                                self.next.toggle()
                            },
                            label: {
                                
                                WebImage(url: URL(string: postModel.coverPic)!)
                                    .resizable()
                                    .frame(width: getRectView().width, height: 170, alignment: .center)
                                    .clipped()
                            }
                        )
                        
                        HStack {
                            ZStack {
                                HStack {
                                    if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                    }
                                    
                                    else {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                        
                                        Text("-")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(postModel.endDate, style: .date)
                                            .font(.custom("Inter-Regular", size: 14))
                                            .foregroundColor(.white)
                                            .frame(alignment: .topLeading)
                                    }
                                }.padding(.trailing, 10)
                                
                                HStack {
                                    Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)

                                    Text(postModel.title)
                                        .foregroundColor(.white)
                                        .font(.custom("Inter-Regular", size: 20))
                                        .frame(width: 320, height: 40, alignment: .topLeading)
                                    
                                    Spacer()
                                }.padding(.leading, 10)
                            }
                        }
                    }
                }
            }
            else {}
        }
        
        else {}
    }
    
    func checkIfUserExistsContacts(userId: String, participantId: String, completion: @escaping ((Bool) -> () )) {
        self.userCollection.document(participantId).collection("contact").whereField("uid", isEqualTo: userId).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is a user")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
    
    func check() {
        self.profileService.loadAllEventUsers(postId: postModel.id)
        
        for userId in profileService.usersUid  {
            checkIfUserExistsContacts(userId: Auth.auth().currentUser!.uid, participantId: userId.uid) { result in
                if (result == true) {
                    self.existsAcc = true
                    return
                }
                else {
                    self.existsAcc = false
                }
            }
        }
    }
}



