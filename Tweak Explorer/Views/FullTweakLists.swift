//
//  FullTweakList.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/31/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

struct FullScreenListOnly: View {
    public var subhead: String
    public var tweaks: [Tweak]
    
    init(_ tweaks: [Tweak], subhead: String? = nil) {
        self.tweaks = tweaks
        self.subhead = subhead ?? "iOS Tweaks"
    }
    
    var body: some View {
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
                }
            }
        }
    }
}

struct FullScreenList: View {
    public var subhead: String
    public var tweaks: [Tweak]
    
    init(_ tweaks: [Tweak], subhead: String? = nil) {
        self.tweaks = tweaks
        self.subhead = subhead ?? "iOS Tweaks"
    }
    
    var body: some View {
        ScrollView {
            FullScreenListOnly(self.tweaks, subhead: self.subhead)
            .padding(20)
        }
        .navigationBarTitle(Text(self.subhead), displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(false)
    }
}

struct FullTweakList_Previews: PreviewProvider {
    static var previews: some View {
        FullTweakList()
    }
}
