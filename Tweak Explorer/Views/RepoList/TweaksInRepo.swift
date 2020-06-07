//
//  TweaksInRepo.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/6/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct TweaksInRepo: View {
    var repo: Repo
    var sections: [String: [Tweak]] = [
        "tweak": [Tweak](),
        "widget": [Tweak](),
        "application": [Tweak](),
        "theme": [Tweak](),
    ]
    
    init(_ repo: Repo) {
        self.repo = repo
        for tweak in Array(Database.packages.values) {
            if tweak.repoWithProtocol == repo.url {
                sections["tweak"]!.append(tweak)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                BannerFull(["REPOSITORY", self.repo.name, self.repo.urlNoProtocol], image: self.repo.getIconName(), bannerHeight: 300, repo: true)
                ForEach(Array(sections.keys).sorted(), id: \.self) { sectionName in
                    NavigationLink(
                        destination: FullScreenList(self.sections[sectionName]!,
                        subhead: self.repo.name)
                    ) {
                        VStack {
                            HStack {
                                Text(sectionName.firstUppercased + "s")
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(String(self.sections[sectionName]!.count))
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .opacity(0.5)
                            }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                            Divider()                                    .padding(.leading, 20)
                        }
                    }
                }
            }.padding(.top, 10)
        }
        .navigationBarTitle(Text(repo.name), displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(false)
    }
}

struct TweaksInRepo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TweaksInRepo(Database.repos["packix"]!)
                .environmentObject(User())
        }
    }
}
