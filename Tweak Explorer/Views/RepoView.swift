//
//  RepoView.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/3/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct RepoView: View {
    public var repo: Repo
    
    var body: some View {
        ZStack {
            Image("repobanner1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
            
        }
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView()
    }
}
