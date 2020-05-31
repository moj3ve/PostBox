//
//  Banner.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/29/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

/// Takes arguements: `texts [String]`; optional:  `card`, `image`, `bannerHeight`
struct Banner: View {
    public var texts: [String]
    public var img: String
    public var bannerHeight: CGFloat
    private var hideText: Bool
    
    init (_ texts: [String], image: String? = nil, bannerHeight: CGFloat? = nil) {
        self.texts = texts
        self.img = image ?? "banner1"
        self.bannerHeight = bannerHeight ?? 410
        self.hideText = texts.count == 0
    }
    
    var body: some View {
        ZStack {
            // Image (Stretch)
            GeometryReader { g in
                if (g.frame(in: .global).minY <= 0) {
                    Image(self.img).resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: g.size.width, height: g.size.height)
                        .clipped(antialiased: true)
                } else {
                    Image(self.img).resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: g.size.width, height: g.size.height + g.frame(in: .global).minY)
                        .clipped(antialiased: true)
                        .offset(y: -g.frame(in: .global).minY)
                }
            }.frame(height: self.bannerHeight)
            
            // Text
            if (!self.hideText) {
                VStack (alignment: .leading) {
                    Spacer()
                    Blur(.systemChromeMaterialLight)
                        .frame(height: 17)
                        .mask(Text(texts[0].uppercased())
                            .font(.subheadline)
                            .fontWeight(.semibold))
                    Text(texts[1])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(texts[2])
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                }
                .padding(20)
                .foregroundColor(.white)
            }
        }
        .frame(height: self.bannerHeight)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Banner_Previews: PreviewProvider {
    static var text = ["Reasons to jailbreak", "App Theming", "Change the way your app icons appear."]
    
    static var previews: some View {
        Banner(text)
    }
}
