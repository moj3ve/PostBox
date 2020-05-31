//
//  Paragraph.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct Paragraph: View {
    public var text: String
    public var first: String
    
    init(first: String? = nil, _ text: String) {
        self.text = text
        self.first = first ?? ""
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.first == "" ? "" : self.first + " " )
                    .fontWeight(.semibold)
                + Text(self.text)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct Paragraph_Previews: PreviewProvider {
    static var previews: some View {
        Paragraph(first: "Hello World.", "This is a paragraph view that joins multiple views together to create a nice paragraph view!")
    }
}
