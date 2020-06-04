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
    public var isBlurred: Bool
    private var hideText: Bool
    
    init (_ story: [[String]], bannerHeight: CGFloat? = nil) {
        let bannerInfo = story[0]
        
        self.texts = bannerInfo
        self.img = bannerInfo[3]
        self.isBlurred = bannerInfo[4] == "true"
        self.bannerHeight = bannerHeight ?? 410
        self.hideText = bannerInfo.count == 0
    }
    
    var body: some View {
        ZStack {
            // Image
            Image(self.img).resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.maxX-40, height: self.bannerHeight)
                
            // Text
            if (!self.hideText) {
                if (self.isBlurred) {
                    VStack {
                        Spacer()
                        HStack {
                            VStack (alignment: .leading) {
                                Text(texts[0].uppercased())
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .opacity(0.6)
                                Text(texts[1])
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                Text(texts[2])
                                    .font(.caption)
                                    .fontWeight(.regular)
                                    .padding(.top, 5)
                                    .opacity(0.6)
                            }.padding(20)
                            Spacer()
                        }
                        .background(Blur(.systemChromeMaterial))
                    }
                } else {
                    ZStack {
                        HStack {
                            VStack (alignment: .leading) {
                                Spacer()
                                Text(texts[0].uppercased())
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text(texts[1])
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                Text(texts[2])
                                    .font(.caption)
                                    .fontWeight(.regular)
                                    .padding(.top, 10)
                            }
                            Spacer()
                        }.padding(20).foregroundColor(.white)
                    }
                }
            }
        }
        .frame(height: self.bannerHeight)
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .shadow(color: Color.black.opacity(0.15), radius: 50, y: 30)
    }
    
}

struct BannerCard_Previews: PreviewProvider {
    static var text = ["Reasons to jailbreak", "App Theming", "Change the way your app icons appear."]
    
    static var previews: some View {
        BannerCard(Database.stories["app_theming"]!)
            .environment(\.colorScheme, .dark)
    }
}
