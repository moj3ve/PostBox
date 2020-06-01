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
    
    init(_ tweaks: [Tweak], subhead: String? = nil, title: String? = nil) {
        self.tweaks = tweaks
        self.subhead = subhead ?? "Jailbreak tweaks"
        self.title = title ?? "Essesential Must\nInstall Tweaks"
    }
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                // Background Tap
                NavigationLink(destination: FullScreenList(Constants.tweakLists.long, subhead: self.subhead)) {
                    Color(UIColor.secondarySystemGroupedBackground)
                }.buttonStyle(NoReactionButtonStyle())
                // Text Tap
                NavigationLink(destination: FullScreenList(Constants.tweakLists.long, subhead: self.subhead)) {
                    VStack (alignment: .leading) {
                            Text(self.subhead.uppercased())
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                            HStack {
                                Text(self.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    Spacer ()
                        }
                        Spacer()
                    }.padding(20)
                }.buttonStyle(NoReactionButtonStyle())
                // Section Tap
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(0..<4) { i in
                            HStack {
                                NavigationLink(destination: FullScreenList(Constants.tweakLists.long, subhead: self.subhead)) {
                                    CardViewInnerSection(tweak: self.tweaks[i])
                                }.buttonStyle(NoReactionButtonStyle())
                                ModalLink(destination: {RepoPrompt(dismiss: $0, tweak: self.tweaks[i])}) {
                                    SmallButton(self.tweaks[i].getPrice())
                                }.buttonStyle(InstallButtonStyle())
                            }
                        }
                    }
                }
                .padding(20)
            }
            .frame(height: 395)
            .cornerRadius(15)
            .padding(.horizontal, 20)
            .shadow(color: Color.black.opacity(0.15), radius: 50, y: 30)
        }
        .buttonStyle(CardButtonStyle())
    }
}

struct CardViewInnerSection: View {
    public var tweak: Tweak
    
    var body: some View {
        VStack {
            HStack {
                self.tweak.getIcon(size: 45)
                VStack(alignment: .leading, spacing: 3) {
                    Text(self.tweak.name)
                        .font(.headline)
                    Text(self.tweak.shortDesc)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                Spacer()
            }
        }
    }
}

struct SmallButton: View {
    public var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundColor(.teal)
            .fontWeight(.semibold)
            .zIndex(1)
            .frame(width: 65, height: 26)
            .background(Color.gray.opacity(0.15).cornerRadius(13))
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
