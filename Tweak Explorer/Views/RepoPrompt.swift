//
//  RepoPrompt.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/29/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct RepoPrompt: View {
    @State var selected: Int = 0
    @State var showAlert = false
    var packageManagers = ["Cydia", "Sileo", "Zebra", "Installer"]
    var initialProtocolUrls = ["cydia://url/https://cydia.saurik.com/api/share#?source=",
                               "sileo://source/",
                               "zbra://sources/add/",
                               "installer://add/repo="]
    
    var dismiss: () -> ()
    var tweak: Tweak
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Repo", selection: $selected) {
                    ForEach(0..<packageManagers.count) {
                        Text(self.packageManagers[$0])
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 20)
                
                Spacer()
                
                // Icon | Text | Dev
                self.tweak.getIcon(size: 100)
                Text(self.tweak.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(self.tweak.dev)
                    .font(.headline)
                    .foregroundColor(.lightgray)
                
                Spacer()
                
                if (UIApplication.shared.canOpenURL(URL(string: initialProtocolUrls[selected] + tweak.repoWithProtocol)!)) {
                    Button(action: {
                        let url = self.initialProtocolUrls[self.selected] + self.tweak.repoWithProtocol
                        UIApplication.shared.open(URL(string: url)!)
                    }) {
                        AddRepoButton(selected: self.selected, back: Color.teal)
                    }.buttonStyle(InstallButtonStyle())
                } else {
                    Button(action: {}) {
                        AddRepoButton(selected: self.selected, back: Color.red)
                    }.buttonStyle(InstallButtonStyle())
                }
                
                Text(self.tweak.repo)
                    .font(.callout)
                    .foregroundColor(.lightgray)
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("Get \(self.tweak.name)", displayMode: .inline)
        }
    }
}

struct RepoPrompt_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(destination: {RepoPrompt(dismiss: $0, tweak: Constants.tweak.free)}) {
                Text("Tap Here")
            }
        }
    }
}

struct AddRepoButton: View {
    var selected: Int
    var back: Color
    var packageManagers = ["Cydia", "Sileo", "Zebra", "Installer"]
    
    var body: some View {
        ZStack {
            back.cornerRadius(15)
            Text("Add Repo to \(packageManagers[selected])")
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }.frame(height: 50)
    }
}
