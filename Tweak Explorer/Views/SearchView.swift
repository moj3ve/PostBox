//
//  SearchView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/31/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var searchTerm = ""
    var pkgs: [Tweak]
    var stories: [[[String]]]
    
    init() {
        let pkgs = Array(Database.packages.values)
        let stories = Array(Database.stories.values)

        self.pkgs = pkgs
        self.stories = stories
    }
    
    var body: some View {
        return NavigationView {
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
                                    }
                                }
                            }
                        }
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
                                    }
                                }
                            }
                        }
                    }
                } else {
                    EmptyFill()
                    Spacer()
                }
            }.navigationBarTitle("Search")
        }
    }
}

// PREVIEW
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(User())
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
            Text("Find Packages, Repos, and Stories.\nWant something be on our app, just ask!")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
        }
    }
}
