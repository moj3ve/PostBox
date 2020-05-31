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
    var genderOps = ["🙋‍♂️ Male", "💁‍♀️ Female"]
    var dismiss: () -> ()
    
    var body: some View {
        NavigationView {
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
                        
                        Button("Save", action: {self.user.saveName(self.newName)})
                    }
                }   .padding(40)
                    .padding(.top, 20)
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done", action: {
                self.self.dismiss()
                self.user.savePic(self.genderPics[self.gender])
            }))
        }
    }
}

struct UserPrefs_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: { AccountView(dismiss: $0).environmentObject(User()) },
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
