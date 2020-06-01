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
    @State var showActionMenu = false
    
    var packageManagers = ["Cydia", "Sileo", "Zebra", "Installer"]
    var initialProtocolUrls = ["cydia://url/https://cydia.saurik.com/api/share#?source=",
                               "sileo://source/",
                               "zbra://sources/add/",
                               "installer://add/repo="]
    
    var dismiss: () -> ()
    var tweak: Tweak
    
    func addRepo(_ selected: Int) {
        let url = self.initialProtocolUrls[selected] + self.tweak.repoWithProtocol
        UIApplication.shared.open(URL(string: url)!)
    }
    
    func appExists(_ selected: Int) -> Bool {
        let url = self.initialProtocolUrls[selected] + self.tweak.repoWithProtocol
        return UIApplication.shared.canOpenURL(URL(string: url)!)
    }
    
    func getApps() -> [ActionSheet.Button] {
        var buttonList = [ActionSheet.Button]()
        for i in (0..<packageManagers.count) {
            if (self.appExists(i)) {
                buttonList.append(.default(Text(packageManagers[i])) { self.addRepo(i) } )
            }
        }
        
        buttonList.append(.cancel())
        return buttonList
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image(tweak.getScreenshot(1)).resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.horizontal)
                        .offset(y: 65)
                    
                    // Icon | Text | Dev
                    VStack {
                        Spacer()
                        VStack {
                            self.tweak.getIcon(size: 100)
                            Text(self.tweak.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(self.tweak.repo)
                                .font(.headline)
                                .opacity(0.8)
                        }
                        Button(action: {self.showActionMenu.toggle()}) {
                            AddRepoButton()
                        }.buttonStyle(InstallButtonStyle())
                        
                        Spacer()
                    }
                        .foregroundColor(.white)
                        .zIndex(1) // VStack
                        .offset(y: 175)
                    
                    VStack {
                        Spacer()
                        Blur(.systemUltraThinMaterialDark)
                            .frame(height: 300)
                    }
                    
                    
                }
            }
            .actionSheet(isPresented: self.$showActionMenu) {
                ActionSheet(title: Text("Select Package Manager"),
                message: Text("Click the info button on the top left for more information on package managers."),
                buttons: self.getApps())
            }
            .navigationBarTitle("Get \(self.tweak.name)", displayMode: .inline)
            .navigationBarItems(
                leading: NavigationLink(destination: Info(dismiss: self.dismiss)) {Image(systemName: "info.circle").font(.system(size: 20))},
                trailing: Button (action: {
                    self.self.dismiss()
                }) {Text("Done").fontWeight(.semibold)}
            )
        }
    }
}

struct Info: View {
    var dismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                Banner(["JAILBREAK INFO", "Package Managers", "What is a package manager?"], image: "banner3", bannerHeight: 300, blur: true, inModal: true)
                
                Paragraph(first: "Package managers are", "applications that help users ")
                    .padding(20)
                
                CardList(Constants.tweakLists.paid)
            }
        }
        .navigationBarTitle("Package Managers", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(false)
        .navigationBarItems(
            trailing: Button (action: {
                self.self.dismiss()
            }) {Text("Done").fontWeight(.semibold)}
        )
            
    }
}

struct AddRepoButton: View {
    var body: some View {
        ZStack {
            Color.teal.cornerRadius(10)
            Text("Add Repo")
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .frame(width: 212, height: 45)
    }
}

struct RepoPrompt_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(destination: {RepoPrompt(dismiss: $0, tweak: Constants.tweak.paid!)}) {
                SmallButton("Get")
            }.buttonStyle(InstallButtonStyle())
        }
    }
}
