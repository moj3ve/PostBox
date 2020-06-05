//
//  UserPrefs.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/5/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

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

struct UserPrefs_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: { UserPrefs(dismiss: $0).environmentObject(User()) },
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
