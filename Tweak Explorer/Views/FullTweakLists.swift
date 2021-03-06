//
//  FullTweakList.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/31/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct FullScreenListOnly: View {
    @EnvironmentObject var user: User
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
                        tweak.getIcon(size: 80).padding(.trailing, 10)
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
                                }
                            }.buttonStyle(NoReactionButtonStyle())
                            
                            Spacer()
                            
                            ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: tweak).environmentObject(self.user)}) {
                                SmallButton(tweak.getPrice())
                            }.buttonStyle(InstallButtonStyle())
                        }
                        .frame(height: 80)
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
            if (self.tweaks.count >= 1) {
                FullScreenListOnly(self.tweaks, subhead: self.subhead)
                    .padding(20)
            } else {
                VStack {
                    Image("empty").resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(0.8)
                    Text("This section is empty!")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    Spacer()
                }
            }
        }
        .navigationBarTitle(Text(self.subhead), displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(false)
    }
}

struct FullTweakList_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenList(Constants.tweakLists.long)
    }
}
