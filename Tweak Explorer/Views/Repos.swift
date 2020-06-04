//  Repos.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/2/20.
//  Copyright © 2020 icycabbage. All rights reserved.


import SwiftUI
import ModalView

struct Repos: View {
    @EnvironmentObject var user: User
    @State var showTop = false
    
    /// Updates `showtop` when scrolling
    private func updateTop(_ g: GeometryProxy) -> some View {
        self.showTop = g.frame(in: .global).minY <= 20
        return Rectangle().frame(width: 0, height: 0)
    }
    
    var body: some View {
        GeometryReader { g in
            Blur(.systemChromeMaterial)
                .frame(width: UIScreen.main.bounds.maxX, height: g.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.all)
                .zIndex(2)
                .opacity(self.showTop ? 1 : 0)
                .animation(.easeIn(duration: 0.2), value: self.showTop)
            
            ScrollView {
                VStack {
                    GeometryReader { g_in in self.updateTop(g_in) }
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Spacer()
                                Text("Repos")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            VStack {
                                Spacer()
                                ModalLink(destination: {
                                    AccountView(dismiss:$0)
                                        .environmentObject(self.user)
                                        .accentColor(.teal)
                                }) { SmallProfile() }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal, 20)
                    }
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            RepoCard(Database.repoOld["packix"]!)
                            RepoCard(Database.repoOld["chariz"]!)
                        }.padding(.horizontal, 20)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Popular Free Tweaks")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            Text("See All")
                            .foregroundColor(.teal)
                        }
                    }.padding(20)
                    
                    Spacer()
                }
            }
        }
    }
}

struct RepoCard: View {
    public var repoText: [String]
    public var repoImg: String
    public var repoCardHeight: CGFloat
    public var repoIsBlurred: Bool
    private var repoHideText: Bool
    
    init (_ repotitle: [[String]], repoCardHeight: CGFloat? = nil) {
        let repoInfo = repotitle[0]
        
        self.repoText = repoInfo
        self.repoImg = repoInfo[3]
        self.repoIsBlurred = repoInfo[4] == "true"
        self.repoCardHeight = 240
        self.repoHideText = repoInfo.count == 0
    }
    
    var body: some View {
        ZStack {
            Image(self.repoImg).resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 313, height: self.repoCardHeight)
            
            if (!self.repoHideText) {
                if (self.repoIsBlurred) {
                    VStack {
                        Spacer()
                        HStack {
                            VStack (alignment: .leading) {
                                Text(repoText[0].uppercased())
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .opacity(0.6)
                                Text(repoText[1])
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text(repoText[2])
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.top, 3)
                                    .opacity(0.8)
                            }.padding(20)
                            Spacer()
                        }
                        .background(Blur(.systemChromeMaterial))
                    }
                } else {
                    ZStack {
                        HStack {
                            VStack (alignment: .leading) {
                                Spacer()
                                Text(repoText[0].uppercased())
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .opacity(0.6)
                                Text(repoText[1])
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text(repoText[2])
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 3)
                                    .opacity(0.8)
                            }
                            Spacer()
                        }.padding(20).foregroundColor(.white)
                    }
                }
            }
        }
            .cornerRadius(15)
    }
}

struct Repos_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            NavigationView {
                Repos()
                    .environmentObject(User())
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            }
        }
    }
}
