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
        ScrollView(showsIndicators: true) {
            VStack(alignment: .center, spacing: 30) {
                ReposNavBar().zIndex(1)
                ScrollView(.horizontal, showsIndicators: false) {
                    Text("test")
                }

                
                
            }
        }
}

struct ReposNavBar: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("Featured")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            }
            Spacer()
            }
            .padding(.top, 25)
            .padding(.horizontal, 20)
        }
    }
     
}



struct Repos_Previews: PreviewProvider {
    static var previews: some View {
        Repos()
    }
}
