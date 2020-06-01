//
//  BannerCard.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/29/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct BannerCard: View {
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
            // Image
            Image(self.img).resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .clipped(antialiased: true)
                .frame(width: UIScreen.main.bounds.maxX-40, height: self.bannerHeight)
                
            // Text
            if (!self.hideText) {
                VStack {
                    Spacer()
                    HStack {
                        VStack (alignment: .leading) {
                            Text(texts[0].uppercased())
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .opacity(0.6)
                            Text(texts[1])
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(texts[2])
                                .font(.caption)
                                .fontWeight(.semibold)
                                .padding(.top, 5)
                                .opacity(0.6)
                        }.padding(20)
                        Spacer()
                    }
                    .background(Blur(.systemChromeMaterial))
                }
            }
        }
        .frame(height: self.bannerHeight)
        .cornerRadius(15)
        .padding(.horizontal, 20)
    }
    
}

struct BannerCardFull: View {
    public var texts: [String]
    public var img: String
    public var bannerHeight: CGFloat
    private var hideText: Bool
    
    init (_ texts: [String], image: String? = nil, bannerHeight: CGFloat? = nil) {
        self.texts = texts
        self.img = image ?? "banner1.1"
        self.bannerHeight = bannerHeight ?? 410
        self.hideText = texts.count == 0
    }
    
    var body: some View {
        ZStack {
            // Image
            Image(self.img).resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .clipped(antialiased: true)
                .frame(width: UIScreen.main.bounds.maxX - 40, height: self.bannerHeight)
                
            // Text
            if (!self.hideText) {
                ZStack {
                    HStack {
                        VStack (alignment: .leading) {
                            Spacer()
                            Text(texts[0].uppercased())
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(texts[1])
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(texts[2])
                                .font(.caption)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                        }
                        Spacer()
                    }.padding(20).foregroundColor(.white)
                }
            }
        }
        .frame(height: self.bannerHeight)
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .shadow(radius: 15, y: 10)
    }
    
}

struct BannerCard_Previews: PreviewProvider {
    static var text = ["Reasons to jailbreak", "App Theming", "Change the way your app icons appear."]
    
    static var previews: some View {
        BannerCard(text)
            .environment(\.colorScheme, .dark)
    }
}
