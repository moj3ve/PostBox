//
//  Animatin.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/26/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct Animatin: View {
    @State var show = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .scaleEffect(show ? 0.5 : 1)
            .animation(.spring())
            .gesture (
                LongPressGesture(minimumDuration: 0)
                    .onEnded { _ in
                        self.show.toggle()
                    }
            )
        
    }
}

struct Animatin_Previews: PreviewProvider {
    static var previews: some View {
        Animatin()
    }
}
