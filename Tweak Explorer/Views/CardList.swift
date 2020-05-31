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
                NavigationLink(destination: FullSceenList(Constants.tweakLists.long, subhead: self.subhead)) {
                    Color(UIColor.secondarySystemBackground)
                }.buttonStyle(NoReactionButtonStyle())
                // Text Tap
                NavigationLink(destination: FullSceenList(Constants.tweakLists.long, subhead: self.subhead)) {
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
                            Spacer()
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
                                NavigationLink(destination: FullSceenList(Constants.tweakLists.long, subhead: self.subhead)) {
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
                .frame(height: 415)
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .shadow(radius: 30, y: 7)
        }
        .buttonStyle(CardButtonStyle())
    }
}

struct CardViewInnerSection: View {
    public var tweak: Tweak
    
    var body: some View {
        VStack {
            HStack {
                self.tweak.getIcon(size: 50)
                VStack(alignment: .leading) {
                    Text(self.tweak.repo)
                        .lineLimit(1)
                        .font(.caption)
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

struct FullSceenList: View {
    public var subhead: String
    public var tweaks: [Tweak]
    
    init(_ tweaks: [Tweak], subhead: String? = nil) {
        self.tweaks = tweaks
        self.subhead = subhead ?? "iOS Tweaks"
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(self.tweaks) { tweak in
                    HStack(alignment: .top) {
                        // Icon
                        NavigationLink (destination: TweakView(tweak: tweak)) {
                            tweak.getIcon(size: 100).padding(.trailing, 10)
                        }.buttonStyle(NoReactionButtonStyle())
                        // Text | Button | Divider
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 0) {
                                NavigationLink (destination: TweakView(tweak: tweak)) {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(tweak.name)
                                            .font(.body)
                                        Text(tweak.shortDesc)
                                            .font(.footnote)
                                            .foregroundColor(Color.gray)
                                            .lineLimit(2)
                                    }
                                }.buttonStyle(NoReactionButtonStyle())
                                
                                Spacer()
                                
                                ModalLink(destination: {RepoPrompt(dismiss: $0, tweak: tweak)}) {
                                    SmallButton(tweak.getPrice())
                                }.buttonStyle(InstallButtonStyle())
                            }
                                .frame(height: 100)
                            Divider()
                        }
                    }.padding(.horizontal, 20)
                }
            }.padding(.vertical, 20)
        }
        .navigationBarTitle(Text(self.subhead), displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(false)
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
            .foregroundColor(.white)
            .fontWeight(.bold)
            .zIndex(1)
            .frame(width: 70, height: 28)
            .background(Color.teal.cornerRadius(15))
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
        FullSceenList(Constants.tweakLists.long)
    }
}
