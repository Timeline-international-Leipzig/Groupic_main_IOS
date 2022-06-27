//
//  SocialPostCardView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.04.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SocialPostCardView: View {
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
            
            //SocialPostCard 1
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
                            
                            if userModel.uid != Auth.auth().currentUser!.uid {
                                Text(userModel.username + ": ")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                            }
                            else {
                                Text("du: ")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.publishTime))
                                .timeAgo())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(.white)
                            .frame(alignment: .topLeading)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }.padding(.leading, 5)
                
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
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 4),
                              alignment: .leading, spacing: 4, content: {
                        ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                            if item.type == "IMAGE" {
                                WebImage(url: URL(string: item.uriOrUid)!)
                                    .resizable()
                                    .frame(width: getRectView().width / 4.3, height: getRectView().width / 4.3, alignment: .leading)
                                    .clipped()
                                    .padding(.top, 8)
                            }
                            else {
                            }
                        }
                    })
                    
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
            .onAppear {
                self.profileService.loadAllEventElements(postId: postModel.id)
            }
        }
        
        if exist == false && postModel.index == 0 {
            NavigationLink(destination: EventViewOnlyContactView(postModel: postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            //SocialPostCard 2
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                
                                Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                            }
                            
                            if userModel.uid != Auth.auth().currentUser!.uid {
                                Text(userModel.username + ": ")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                            }
                            else {
                                Text("du: ")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.publishTime))
                                .timeAgo())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(.white)
                            .frame(alignment: .topLeading)
                        }
                        .padding(.leading, 5)
                    }
                    
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            
                            WebImage(url: URL(string: postModel.coverPic)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 200)
                                .clipped()
                        }
                    )
                    
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 4),
                              alignment: .leading, spacing: 4, content: {
                        ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                            if item.type == "IMAGE" {
                                WebImage(url: URL(string: item.uriOrUid)!)
                                    .resizable()
                                    .frame(width: getRectView().width / 4.3, height: getRectView().width / 4.3)
                                    .clipped()
                                    .padding(.top, 8)
                                
                            }
                            else {
                            }
                        }
                    })
                    
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
            .onAppear {
                self.profileService.loadAllEventElements(postId: postModel.id)
            }
        }
        
        if exist == true && postModel.index == 1 {
            NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            //SocialPostCard 3
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                
                                Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                            }
                            
                            if userModel.uid != Auth.auth().currentUser!.uid {
                                Text(userModel.username + ": ")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(.white)
                            }
                            else {
                                Text("du: ")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(.white)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.publishTime))
                                .timeAgo())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(.white)
                        }
                        .padding(.leading, 5)
                    }
                    
                    Spacer()
                }
                
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
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 4),
                              alignment: .leading, spacing: 4, content: {
                        ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                            if item.type == "IMAGE" {
                                WebImage(url: URL(string: item.uriOrUid)!)
                                    .resizable()
                                    .frame(width: getRectView().width / 4.3, height: getRectView().width / 4.3, alignment: .center)
                                    .clipped()
                                    .padding(.top, 8)
                            }
                            else {
                            }
                        }
                    })
                    
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
                                
                                Spacer()
                            }.padding(.leading, 10)
                        }
                    }
                }
            }
            .onAppear {
                self.profileService.loadAllEventElements(postId: postModel.id)
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
                
                //SocialPostCard 4
                VStack(spacing: 0) {
                    HStack {
                        VStack {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                    
                                    Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                                }
                                
                                if userModel.uid != Auth.auth().currentUser!.uid {
                                    Text(userModel.username + ": ")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                                else {
                                    Text("du: ")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                                
                                Text((Date(timeIntervalSince1970: postModel.publishTime))
                                    .timeAgo())
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            }
                        }.padding(.leading, 5)
                        
                        Spacer()
                        
                    }
                    
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
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 4),
                                  alignment: .leading, spacing: 4, content: {
                            ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                                if item.type == "IMAGE" {
                                    WebImage(url: URL(string: item.uriOrUid)!)
                                        .resizable()
                                        .frame(width: getRectView().width / 4.3, height: getRectView().width / 4.3, alignment: .center)
                                        .clipped()
                                        .padding(.top, 8)
                                }
                                else {
                                }
                            }
                        })
                        
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
                                        .font(.custom("Inter-Regular", size: 20))
                                    
                                    Spacer()
                                }.padding(.leading, 10)
                            }
                        }
                    }
                }
                .onAppear {
                    self.profileService.loadAllEventElements(postId: postModel.id)
                }
            }
            
            if exist == true && postModel.index == 2 {
                NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                //SocialPostCard 5
                VStack(spacing: 0) {
                    HStack {
                        VStack {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                    
                                    Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                                }
                                
                                if userModel.uid != Auth.auth().currentUser!.uid {
                                    Text(userModel.username + ": ")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                                else {
                                    Text("du: ")
                                        .font(.custom("Inter-Regular", size: 14))
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                                
                                Text((Date(timeIntervalSince1970: postModel.publishTime))
                                    .timeAgo())
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            }
                        }.padding(.leading, 5)
                        
                        Spacer()
                    }
                    
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
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 4),
                                  alignment: .leading, spacing: 4, content: {
                            ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                                if item.type == "IMAGE" {
                                    WebImage(url: URL(string: item.uriOrUid)!)
                                        .resizable()
                                        .frame(width: getRectView().width / 4.3, height: getRectView().width / 4.3, alignment: .center)
                                        .clipped()
                                        .padding(.top, 8)
                                }
                                else {
                                }
                            }
                        })
                        
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
                                        .font(.custom("Inter-Regular", size: 20))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                }.padding(.leading, 10)
                            }
                        }
                    }
                }
                .onAppear {
                    self.profileService.loadAllEventElements(postId: postModel.id)
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



