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
                            ForEach(Constants.repoLists.editorsPicks) { repo in
                                RepoCard(repo)
                            }
                        }
                        .padding(20)
                        .padding(.bottom, 20)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Popular Repos")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            Text("See All")
                                .foregroundColor(.teal)
                        }
                    }.padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
        }
    }
}

struct RepoCard: View {
    public var repo: Repo
    public var category: String
    
    init (_ repo: Repo, category: String? = nil) {
        self.repo = repo
        self.category = category ?? "Recommended Repo"
    }
    
    var body: some View {
        ZStack {
            repo.getBanner()
                .aspectRatio(contentMode: .fill)
                .frame(width: 313, height: 240)
            
            ZStack {
                HStack {
                    VStack (alignment: .leading) {
                        Spacer()
                        Text(category.uppercased())
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .opacity(0.6)
                        Text(repo.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(repo.url)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.top, 3)
                            .opacity(0.8)
                    }
                    Spacer()
                }.padding(20).foregroundColor(.white)
            }
            
        }
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.15), radius: 15, y: 10)
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
