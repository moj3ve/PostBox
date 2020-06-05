//
//  UserPrefs.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct Settings: View {
    @EnvironmentObject var user: User
    var dismiss: () -> ()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: UserPrefs(dismiss: self.dismiss)) {
                        HStack(spacing: 15) {
                            Image(self.user.img).resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 58, height: 58)
                                .padding(.leading, 5)
                            VStack (alignment: .leading, spacing: 3) {
                                Text(self.user.name)
                                Text("Avid Jailbreaker")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: WishlistView(dismiss: self.dismiss)) {
                        Text("Wishlist")
                    }.padding(.leading, 5)
                }
                
                Section {
                    NavigationLink(destination: WishlistView(dismiss: self.dismiss)) {
                        Text("Changelog")
                    }.padding(.leading, 5)
                    NavigationLink(destination: WishlistView(dismiss: self.dismiss)) {
                        Text("Credits")
                    }.padding(.leading, 5)
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: self.dismiss) {
                Text("Done").fontWeight(.medium)
            })
        }
    }
}

struct UserPrefs: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var user: User
    @State var newName = ""
    @State var gender = 0
    
    var dismiss: () -> ()
    
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
                    .fontWeight(.medium)
                
                HStack {
                    Picker("Gender", selection: $gender) {
                        ForEach(0..<genderOps.count) {
                            Text(self.genderOps[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }.padding(.top, 50)
                
                
                TextField("Name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }   .padding(40)
                .padding(.top, 20)
        }
        .navigationBarTitle("Account Settings", displayMode: .inline)
        .navigationBarItems(trailing: Button (action: {
            self.mode.wrappedValue.dismiss()
            self.user.saveName(self.newName)
            self.user.savePic(self.genderPics[self.gender])
        }) {Text("Save").fontWeight(.medium)})
    }
}

struct WishlistView: View {
    @EnvironmentObject var user: User
    @State var sortMethod = 0
    
    var dismiss: () -> ()
    var sortMethods = ["Alphabetical", "Date"]
    
    var body: some View {
        ModalPresenter {
            ZStack {
                VStack {
                    Picker("Gender", selection: $sortMethod) {
                        ForEach(0..<sortMethods.count) {
                            Text(self.sortMethods[$0])
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(10)
                        .background(Blur(.systemMaterial))
                    
                    Spacer()
                }.zIndex(1)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(sortMethod == 0 ? self.user.getWishlist().sorted() : self.user.getWishlist()) { tweak in
                            HStack(alignment: .top) {
                                // Icon
                                NavigationLink (destination: TweakView(tweak: tweak)) {
                                    tweak.getIcon(size: 100).padding(.trailing, 10)
                                }.buttonStyle(NoReactionButtonStyle())
                                // Text | Button | Divider
                                VStack(alignment: .leading, spacing: 20) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        NavigationLink (destination: TweakView(tweak: tweak)) {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(tweak.name)
                                                    .font(.body)
                                                Text(tweak.shortDesc)
                                                    .font(.footnote)
                                                    .foregroundColor(Color.gray)
                                                    .lineLimit(2)
                                            }
                                        }.buttonStyle(NoReactionButtonStyle())
                                        
                                        Spacer()
                                        
                                        ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: tweak)}) {
                                            SmallButton(tweak.getPrice())
                                        }.buttonStyle(InstallButtonStyle())
                                    }
                                        .frame(height: 100)
                                    Divider()
                                }
                            }.padding(.horizontal, 20)
                        }
                    }
                }.padding(.top, 80)
            }
                .navigationBarTitle("Wishlist", displayMode: .inline)
                .navigationBarItems(trailing: Button (action: {
                    self.dismiss()
            }) {Text("Done").fontWeight(.medium)})
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: { Settings(dismiss: $0).environmentObject(User()) },
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
