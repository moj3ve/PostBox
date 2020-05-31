//
//  UserPrefs.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct AccountView: View {
    @EnvironmentObject var user: User
    
    @State var newName = ""
    @State var gender = 0
    
    var genderPics = ["generic", "generic_f"]
    var genderOps = ["Picture #1", "Picture #2"]
    var dismiss: () -> ()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: UserPrefs()) {
                        HStack(spacing: 15) {
                            Image(self.user.img).resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 58, height: 58)
                                .padding(.leading, 5)
                            VStack (alignment: .leading, spacing: 3) {
                                Text(self.user.name)
                                Text("nath49ers@gmail.com")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: UserPrefs()) {
                        Text("Wishlists")
                    }.padding(.leading, 5)
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: {
                self.self.dismiss()
            }) {Text("Done").fontWeight(.semibold)})
        }
    }
}

struct UserPrefs: View {
    @EnvironmentObject var user: User
    @State var newName = ""
    @State var gender = 0
    
    var genderPics = ["generic", "generic_f"]
    var genderOps = ["Picture #1", "Picture #2"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(genderPics[gender]).resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 15)
                    .onAppear(perform: {self.gender = self.user.img == "generic" ? 0 : 1})
                
                Text(user.name == "" ? "Guest" : user.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Picker("Gender", selection: $gender) {
                        ForEach(0..<genderOps.count) {
                            Text(self.genderOps[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }.padding(.top, 50)
                
                HStack {
                    TextField("Name", text: $newName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save", action: {
                        self.user.saveName(self.newName)
                        self.user.savePic(self.genderPics[self.gender])
                    })
                }
            }   .padding(40)
                .padding(.top, 20)
        }
    }
}

struct WishlistView: View {
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: { AccountView(dismiss: $0).environmentObject(User()) },
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
