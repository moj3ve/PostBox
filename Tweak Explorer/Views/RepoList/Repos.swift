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
        self.showTop = g.frame(in: .global).minY <= 15
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
                    // Blur
                    GeometryReader { g_in in self.updateTop(g_in) }
                    
                    // Header
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
                                    Settings(dismiss:$0)
                                        .environmentObject(self.user)
                                        .accentColor(.teal)
                                }) { SmallProfile() }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal, 20)
                    }
                    
                    // Horizontal Scroll View
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Constants.repoLists.editorsPicks.sorted()) { repo in
                                ModalLink(destination: {RepoPrompt(dismiss: $0, repo: repo)}) {
                                    RepoCard(repo)
                                }.buttonStyle(CardButtonStyle())
                            }
                        }
                        .padding(20)
                        .padding(.bottom, 20)
                    }
                    
                    // Main List
                    VStack(alignment: .leading, spacing: 23) {
                        // List title
                        HStack {
                            Text("Expand Your Tweak Library")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("See All")
                                .foregroundColor(.teal)
                                .font(.callout)
                        }
                        
                        ForEach(Array(Database.repos.values).sorted().prefix(8)) { repo in
                            NavigationLink (destination: TweaksInRepo(repo)) {
                                HStack (spacing: 20){
                                    repo.getIcon(size: 50)
                                    VStack(alignment: .leading) {
                                        Text(repo.name).font(.headline)
                                            .foregroundColor(.primary)
                                        Text(repo.url).font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.gray)
                                        .opacity(0.5)
                                }
                            }.buttonStyle(DefaultButtonStyle())
                        }
                    }
                        .padding([.bottom, .horizontal], 20)
                    
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
        self.category = category ?? "Recommended"
    }
    
    var body: some View {
        ZStack {
            Image(repo.getIconName()).resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.05)
                .frame(width: 313, height: 240)
                .edgesIgnoringSafeArea(.bottom)
                .brightness(-0.15)
                .blur(radius: 20)
                .frame(width: 313, height: 240)
            
            ZStack {
                HStack {
                    VStack (alignment: .leading) {
                        Spacer()
                        Text(category.uppercased())
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .opacity(0.6)
                        Text(repo.name)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Text(repo.urlNoProtocol)
                            .font(.caption)
                            .fontWeight(.regular)
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
