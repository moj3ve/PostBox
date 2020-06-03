//
//  ContentView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

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

struct ContentView: View {
    var body: some View {
        ModalPresenter {
            TabView {
                Tab(title: "Home", img: "house.fill", hidden: true) { Home() }
                Tab(title: "Tweaks", img: "cube.box.fill", hidden: true) { Tweaks() }
//                Tab(title: "Repos", img: "folder.fill", hidden: true) { Repos() }
                Tab(title: "Search", img: "magnifyingglass", hidden: false) { SearchView() }
            }
        }
            .accentColor(.teal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(User())
    }
}
