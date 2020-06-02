//
//  Paragraph.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct StoryBlock: View {
    public var text: String
    public var first: String
    public var image = false
    
    init(first: String? = nil, _ text: String, image: Bool? = nil) {
        self.text = text
        self.first = first ?? ""
        self.image = image ?? false
    }
    
    var body: some View {
        VStack {
            if (!self.image) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.first == "" ? "" : self.first + " " )
                            .fontWeight(.semibold)
                            + Text(self.text)
                                .foregroundColor(.gray)
                    }
                    Spacer()
                }
            } else {
                VStack(spacing: 0) {
                    Image(self.first).resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        Text(self.text)
                            .font(.callout)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(20)
                    .background(Color(.secondarySystemBackground))
                }
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 15, y: 10)
            }
        }
    }
}

struct Paragraph_Previews: PreviewProvider {
    static var previews: some View {
        StoryBlock(first: "Hello World.", "This is a paragraph view that joins multiple views together to create a nice paragraph view! \n\nTheETHETHETHETHETHETHETHETHEKSUYDFsuydfgosudyfgwoeiru gosidufgsoidfug osidfug odiufgsoidufg sdoifug osidfugpaieurgf padofg [ad8ofg [odfug paidugf pa8esgf pa9d8fg padf8ug ")
    }
}
