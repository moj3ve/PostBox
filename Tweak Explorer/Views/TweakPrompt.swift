//
//  RepoPrompt.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/29/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct TweakPrompt: View {
    @State var showActionMenu = false
    @State var popup = false
    
    public var dismiss: () -> ()
    public var tweak: Tweak
    
    var packageManagers = ["Cydia", "Sileo", "Zebra", "Installer"]
    var initialProtocolUrls = [
        "cydia://url/https://cydia.saurik.com/api/share#?source=",
        "sileo://source/",
        "zbra://sources/add/",
        "installer://add/repo="
    ]
    
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
        ZStack {
            Image(tweak.getIconName()).resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.05)
                .frame(width: UIScreen.main.bounds.maxX)
                .edgesIgnoringSafeArea(.bottom)
                .brightness(-0.15)
                .blur(radius: 20)
                .frame(width: UIScreen.main.bounds.maxX)
            
            
            CloseModalButton(dismiss: self.dismiss)
            
            VStack (alignment: .leading, spacing: 20) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("ADD TWEAK")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .opacity(0.6)
                        .padding(.bottom, 5)
                    
                    Text(self.tweak.name)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }.padding(.horizontal, 10)
                
                HStack {
                    Text(self.tweak.repo)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .lineLimit(1)
                    Spacer()
                    Button(action: {self.showActionMenu.toggle()}) {
                        SmallButton("ADD")
                    }.padding(.horizontal, 15)
                }
                    .frame(height: 50)
                    .background(Blur(.systemThinMaterial))
                    .cornerRadius(9)
                    .offset(y: self.popup ? 0 : 200)
                    .onAppear(perform: {self.popup.toggle()})
                    .animation(.spring(response: 1), value: self.popup)
            }.padding(20)
        }
        .actionSheet(isPresented: self.$showActionMenu) {
            ActionSheet(title: Text("Select Package Manager"),
                        message: Text("Check the FAQ in settings for more info."),
                        buttons: self.getApps())
        }
    }
}

struct Info: View {
    @EnvironmentObject var user: User
    var dismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                Banner(["FAQ", "Package Managers", "What is a package manager?"], image: "banner3", bannerHeight: 300, inModal: true)
                
                VStack (alignment: .leading, spacing: 20) {
                    StoryBlock(first: "Package managers are", "applications that help users install, remove, and update packages on their jailbroken devices. Although not required, package installers are highly recommended for *ALL users. Most are intuitive, efficient, and written to save time.")
                    
                    StoryBlock(first: "Removing and adding", "APT repositories (sources) have never been easier. Simply give a package manager a valid URL and it will do the rest! All tweaks from added sources will be indexed in search.")

                }.padding(.leading, 20).padding(.trailing, 10)
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
                .font(.callout)
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
        .frame(width: 212, height: 40)
    }
}

struct RepoPrompt_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            VStack (spacing: 20) {
                ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: Constants.tweak.paid!).environmentObject(User())}) {
                    SmallButton("One")
                }.buttonStyle(InstallButtonStyle())
                
                ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: Constants.tweak.free!).environmentObject(User())}) {
                    SmallButton("Two")
                }.buttonStyle(InstallButtonStyle())
                
                ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: Constants.db["lockplus_pro"]!).environmentObject(User())}) {
                    SmallButton("Three")
                }.buttonStyle(InstallButtonStyle())
            }
        }
            .environmentObject(User())
            .environment(\.colorScheme, .dark)
    }
}

/**
struct RepoPromptOld: View {
    @EnvironmentObject var user: User
    @State var selected: Int = 0
    @State var showAlert = false
    @State var showActionMenu = false
    @State var copied = false
    
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
    
    // Sharesheet
    func copyURL() {
        self.copied = true
        let string = tweak.repoWithProtocol
        UIPasteboard.general.string = string
    }
    
    var body: some View {
        ModalPresenter {
            NavigationView {
                ZStack {
                    GeometryReader { g in
                        VStack {
                            self.tweak.getFull()
                                .frame(height: g.size.height)
                            
                            Spacer()
                        }
                    }
                    
                    VStack {
                        Spacer()
                        Blur(.systemThinMaterialDark)
                            .frame(height: 260)
                            .overlay(
                                VStack {
                                    Spacer()
                                    VStack {
                                        self.tweak.getIcon(size: 130)
                                        Text(self.tweak.name)
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                        Text(self.tweak.repo)
                                            .font(.headline)
                                            .opacity(0.8)
                                            .padding(10)
                                    }
                                    Button(action: {self.showActionMenu.toggle()}) {
                                        AddRepoButton()
                                    }.buttonStyle(InstallButtonStyle())
                                    
                                    Spacer()
                                }
                                .offset(y: -52)
                                    .foregroundColor(.white)
                            )
                            .overlay(VStack {
                                HStack {
                                    Button(action: {self.user.toggleWishlistItem(self.tweak)}) {
                                        Image(systemName: self.user.inWishlist(tweak) ? "heart.fill" : "heart")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(self.user.inWishlist(tweak) ? .red : .white)
                                            .opacity(0.8)
                                            .padding(20)
                                    }
                                    Spacer()
                                    Button(action: {self.copyURL()}) {
                                        Image(systemName: "doc.on.clipboard")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(self.copied ? .green : .white)
                                            .opacity(0.8)
                                            .rotationEffect(.degrees(self.copied ? 360 : 0))
                                            .animation(.spring(dampingFraction: 0.1))
                                            .padding(20)
                                    }
                                }
                                Spacer()
                            })
                    }.edgesIgnoringSafeArea(.bottom)
                    
                    
                }
                .actionSheet(isPresented: self.$showActionMenu) {
                    ActionSheet(title: Text("Select Package Manager"),
                                message: Text("Click the info button for more information."),
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
}
**/
