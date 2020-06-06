//
//  ContentView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct ContentView: View {
    @State var showWelcome = !UserDefaults.standard.bool(forKey: "welcomed")
    
    init() {
        if (UserDefaults.standard.object(forKey: "welcomed") == nil) {
            UserDefaults.standard.set(false, forKey: "welcomed")
        }
    }
    
    var body: some View {
        ZStack {
            ModalPresenter {
                TabView {
                    Tab(title: "Home", img: "house.fill", hidden: true) { Home() }
                    Tab(title: "Tweaks", img: "cube.box.fill", hidden: true) { Tweaks() }
                    Tab(title: "Repos", img: "folder.fill", hidden: true) { Repos() }
                    Tab(title: "Search", img: "magnifyingglass", hidden: false) { SearchView() }
                }
            }
            
            if (showWelcome) {
                WelcomePage(showWelcome: $showWelcome.animation(.easeOut))
                    .transition(.opacity)
                    .zIndex(1)
            }
        }.accentColor(.teal)
    }
}

struct WelcomePage: View {
    @EnvironmentObject var user: User
    @Binding var showWelcome: Bool
    
    @State var animate = false
    @State var page = 0
    
    @State var newName = ""
    @State var gender = 0
    
    var genderPics = ["generic", "generic_f"]
    var genderOps = ["Picture #1", "Picture #2"]
    
    var body: some View {
        VStack {
            if page == 0 {
                ZStack {
                    Color(.secondarySystemBackground)
                        .edgesIgnoringSafeArea(.all)
                    Image("mailbox").resizable()
                        .scaledToFit()
                        .scaleEffect(0.6)
                        .offset(y: animate ? -20 : 150)
                    VStack {
                        Text("PostBox")
                            .font(.system(size: 55))
                            .fontWeight(.semibold)
                            .padding(.top, 100)
                        Spacer()
                        Button(action: {
                            self.page += 1
                        }) {
                            LongButton("Continue")
                                .padding(.bottom, 25)
                        }.buttonStyle(InstallButtonStyle())
                    }.opacity(animate ? 1 : -10)
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeInOut(duration: 1))
                .onAppear(perform: {
                    self.animate.toggle()
                })
            } else if page == 1{
                ZStack {
                    Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all)
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
                        
                        Spacer()
                        Button(action: {
                            self.user.saveName(self.newName)
                            self.user.savePic(self.genderPics[self.gender])
                            self.showWelcome.toggle()
                            UserDefaults.standard.set(true, forKey: "welcomed")
                        }) {
                            LongButton("Continue")
                                .padding(.bottom, 25)
                        }.buttonStyle(InstallButtonStyle())
                        
                    }
                        .padding(40)
                        .padding(.top, 20)
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeInOut(duration: 1))
            }
        }
    }
}

struct Tab<Content: View>: View {
    let title: String
    let img: String
    let hidden: Bool
    let view: () -> Content
    
    var body: some View {
        NavigationView {
            if hidden {
                view()
                    .navigationBarTitle("\(title)", displayMode: .inline)
                    .navigationBarHidden(true)
            } else {
                view()
            }
        }.tabItem {
            VStack {
                Image(systemName: img)
                Text(title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(User())
    }
}
