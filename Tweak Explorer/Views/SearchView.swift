//  SearchView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/31/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct SearchView: View {
    @State var searchTerm = ""
    var pkgs: [Tweak]
    var stories: [Story]
    var repos: [Repo]
    
    init() {
        let pkgs = Array(Database.packages.values).sorted()
        let stories = Array(Database.stories.values)
        let repos = Array(Database.repos.values).sorted()
        
        self.pkgs = pkgs
        self.stories = stories
        self.repos = repos
    }
    
    var body: some View {
       // ScrollView {
            VStack {
                SearchBar(searchTerm: $searchTerm)
                    .disableAutocorrection(true)
                if searchTerm != "" {
                    List {
                        ForEach(pkgs.filter({
                            $0.name.lowercased().hasPrefix(searchTerm.lowercased()) || searchTerm == ""
                        })) { tweak in
                            NavigationLink(destination: TweakView(tweak: tweak)) {
                                HStack {
                                    tweak.getIcon(size: 40)
                                    VStack(alignment: .leading) {
                                        Text(tweak.name)
                                            .font(.callout)
                                        Text(tweak.shortDesc)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                        ForEach(stories.filter({
                            $0.header[1].lowercased().hasPrefix(searchTerm.lowercased()) ||
                                $0.header[2].lowercased().hasPrefix(searchTerm.lowercased()) ||
                            searchTerm == ""
                        })) { story in
                            NavigationLink(destination: StoryView(story)) {
                                HStack {
                                    Image("story_icon").resizable()
                                        .renderingMode(.original)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(CGFloat((13.0/57.0) * Double(40)))
                                    
                                    VStack (alignment: .leading){
                                        Text(story.header[1])
                                            .font(.callout)
                                        Text(story.header[2])
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                        ForEach(repos.filter({
                            $0.name.lowercased().hasPrefix(searchTerm.lowercased()) || searchTerm == ""
                        })) { repo in
                            ModalLink(destination: {RepoPrompt(dismiss: $0, repo: repo)}) {
                                HStack {
                                    repo.getIcon(size: 40)
                                    
                                    VStack (alignment: .leading){
                                        Text(repo.name)
                                            .font(.callout)
                                        Text(repo.urlNoProtocol)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.up")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.gray)
                                        .opacity(0.5)
                                }
                            }
                        }
                    }.id(UUID())
                } else {
                    EmptyFill()
                    Spacer()
                }
            }.navigationBarTitle("Search", displayMode: .large)
        
    }
}

// PREVIEW
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView().environmentObject(User())
        }
    }
}

struct SearchBar: View {
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchTerm)
                .foregroundColor(.primary)
            Button(action: {self.searchTerm = ""}) {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchTerm == "" ? 0 : 1)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal, 15)
    }
}

struct EmptyFill: View {
    var body: some View {
        VStack {
            Image("search").resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.8)
            Text("Find Packages, Repos, and Stories.\nWant something be on our app? just ask!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
        }
    }
}
