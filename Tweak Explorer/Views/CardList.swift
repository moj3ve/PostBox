//
//  CardList.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/26/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct CardList: View {
    @EnvironmentObject var user: User
    public var subhead: String
    public var title: String
    public var tweaks: [Tweak]
    public var tweaksShort: [Tweak]
    
    init(_ tweaks: [Tweak], subhead: String? = nil, title: String? = nil) {
        self.tweaks = tweaks
        self.tweaksShort = Array(tweaks.prefix(4))
        self.subhead = subhead ?? "Jailbreak tweaks"
        self.title = title ?? "Essesential Must\nInstall Tweaks"
    }
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                // Background Tap
                NavigationLink(destination: FullScreenList(self.tweaks, subhead: self.subhead)) {
                    Color(UIColor.secondarySystemGroupedBackground)
                }.buttonStyle(NoReactionButtonStyle())
                
                // Text Tap
                NavigationLink(destination: FullScreenList(self.tweaks, subhead: self.subhead)) {
                    VStack (alignment: .leading) {
                        Text(self.subhead.uppercased())
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                        HStack {
                            Text(self.title)
                                .font(.title)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                            Spacer()
                        }
                        Spacer()
                    }.padding(20)
                }.buttonStyle(NoReactionButtonStyle())
                // Section Tap
                
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(self.tweaksShort) { tweak in
                            HStack {
                                NavigationLink(destination: FullScreenList(self.tweaks, subhead: self.subhead)) {
                                    HStack {
                                        tweak.getIcon(size: 45)
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text(tweak.name)
                                                .font(.body)
                                            Text(tweak.shortDesc)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        }
                                        Spacer()
                                    }
                                }.buttonStyle(NoReactionButtonStyle())
                                ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: tweak).environmentObject(self.user)}) {
                                    SmallButton(tweak.getPrice())
                                }.buttonStyle(InstallButtonStyle())
                            }
                        }
                    }
                }
                .padding(20)
                
            }
                .frame(height: 395)
                .cornerRadius(15, antialiased: false)
                .padding(.horizontal, 20)
                .shadow(color: Color.black.opacity(0.15), radius: 50, y: 30)
        }.buttonStyle(CardButtonStyle())
    }
}

struct SmallButton: View {
    public var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundColor(.teal)
            Text(text)
                .font(.footnote)
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
            .frame(width: 65, height: 26)
            
    }
}

struct MediumButton: View {
    public var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.callout)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.horizontal, 20)
            .zIndex(1)
            .frame(height: 28)
            .background(Color.teal.cornerRadius(14))
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList(Constants.tweakLists.free)
    }
}
