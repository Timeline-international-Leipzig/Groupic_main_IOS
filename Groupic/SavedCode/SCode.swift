//
//  SCode.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//
/*
VStack {
    Text("E-Mail")
        .fontWeight(.bold)
        .foregroundColor(Color("AccentColor"))
        .frame(maxWidth: .infinity, alignment: .leading)
    
    VStack {
        HStack {
            Image(systemName: "mail").padding(.horizontal, 10)
            
            TextField("groupic@mail.com", text: self.$email)
                .autocapitalization(.none)
                .padding(.horizontal, 10)
                .font(.system(size: 15, weight: .bold))
        }
        
        Divider()
            .background(Color("AccentColor"))
            .padding(.top, 7.5)
    }
    .padding(.top, 7.5)
}
.padding(.horizontal, 10)
.padding(.top, 20)

 //Passwort Field
 Text("Passwort")
     .fontWeight(.bold)
     .foregroundColor(Color("AccentColor"))
     .padding(.horizontal, 10)
     .padding(.top, 5)
     .frame(maxWidth: .infinity, alignment: .leading)
 
 HStack() {
     VStack {
         if self.visible {
             TextField("********", text: self.$password)
                 .autocapitalization(.none)
                 .font(.system(size: 15, weight: .bold))
         }
         else {
             SecureField("********", text: self.$password)
                 .autocapitalization(.none)
                 .font(.system(size: 15, weight: .bold))
         }
     }
 
     Button(action: {
         self.visible.toggle()
     }, label: {
         Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
             .foregroundColor(self.color)
     })
 }
 .padding()
 .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("AccentColor"):
     self.color, lineWidth: 2))
 .padding(.horizontal, 10)
 
 */
