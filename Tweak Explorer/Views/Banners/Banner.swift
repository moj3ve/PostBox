//
//  Banner.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/29/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

/// Takes arguements: `texts [String]`; optional:  `card`, `image`, `bannerHeight`
struct BannerFull: View {
    public var texts: [String]
    public var img: String
    public var bannerHeight: CGFloat
    private var hideText: Bool
    private var inModal: Bool
    
    init (_ texts: [String], image: String? = nil, bannerHeight: CGFloat? = nil, inModal: Bool? = nil) {
        self.texts = texts
        self.img = image ?? "banner1.1"
        self.bannerHeight = bannerHeight ?? 410
        self.hideText = texts.count == 0
        self.inModal = inModal ?? false
    }
    
    var body: some View {
        ZStack {
            // Image (Stretch)
            GeometryReader { g in
                if (self.inModal) {
                    if (g.frame(in: .global).minY <= 0) {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height)
                            .clipped()
                            .animation(.easeOut(duration: 0.4))
                    } else {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height + g.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -g.frame(in: .global).minY)
                            .animation(.easeOut(duration: 0.4))
                    }
                } else {
                    if (g.frame(in: .global).minY <= 0) {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height)
                            .clipped()
                    } else {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height + g.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -g.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: self.bannerHeight)
            
            // Text
            if (!self.hideText) {
                VStack (alignment: .leading) {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(texts[0].uppercased())
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .opacity(0.6)
                                .padding(.bottom, 4)
                            Text(texts[1])
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Text(texts[2])
                                .font(.caption)
                                .fontWeight(.regular)
                                .padding(.top, 10)
                                .opacity(0.6)
                        }.padding(20)
                        Spacer()
                    }.foregroundColor(.white)
                }
            }
        }
        .frame(height: self.bannerHeight)
        .edgesIgnoringSafeArea(.all)
    }
}

/// Takes arguements: `texts [String]`; optional:  `card`, `image`, `bannerHeight`
struct Banner: View {
    public var texts: [String]
    public var img: String
    public var bannerHeight: CGFloat
    private var hideText: Bool
    private var inModal: Bool
    
    init (_ texts: [String], image: String? = nil, bannerHeight: CGFloat? = nil, inModal: Bool? = nil) {
        self.texts = texts
        self.img = image ?? "banner1.1"
        self.bannerHeight = bannerHeight ?? 410
        self.hideText = texts.count == 0
        self.inModal = inModal ?? false
    }
    
    var body: some View {
        ZStack {
            // Image (Stretch)
            GeometryReader { g in
                if (self.inModal) {
                    if (g.frame(in: .global).minY <= 0) {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height)
                            .clipped()
                            .animation(.easeOut(duration: 0.4))
                    } else {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height + g.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -g.frame(in: .global).minY)
                            .animation(.easeOut(duration: 0.4))
                    }
                } else {
                    if (g.frame(in: .global).minY <= 0) {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height)
                            .clipped()
                    } else {
                        Image(self.img).resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.size.width, height: g.size.height + g.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -g.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: self.bannerHeight)
            
            // Text
            if (!self.hideText) {
                VStack (alignment: .leading) {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(texts[0].uppercased())
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .opacity(0.6)
                                .padding(.bottom, 4)
                            Text(texts[1])
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Text(texts[2])
                                .font(.caption)
                                .fontWeight(.regular)
                                .padding(.top, 10)
                                .opacity(0.6)
                        }.padding(20)
                        Spacer()
                    }.background(Blur(.systemChromeMaterial))
                }
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
