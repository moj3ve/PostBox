//
//  Repos.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/2/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct Repos: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: true) {
                ScrollView(.horizontal, showsIndicators: false) {
                    BannerCard(Database.repos["packix"]!)
                }
            }
            .navigationBarTitle("Featured")
        }
    }
}
struct Repos_Previews: PreviewProvider {
    static var previews: some View {
        Repos()
    }
}
