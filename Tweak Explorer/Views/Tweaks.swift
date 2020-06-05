//
//  Tweaks.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/26/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct Tweaks: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack {
                // Image (Stretch)
                ZStack {
                    GeometryReader { g in
                        if (g.frame(in: .global).minY <= 0) {
                            Image("banner1.1").resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: g.size.width, height: g.size.height)
                                .clipped()
                        } else {
                            Image("banner1.1").resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: g.size.width, height: g.size.height + g.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -g.frame(in: .global).minY)
                        }
                    }
                        .frame(height: 600)
                    // Text | Button
                    VStack(alignment: .center, spacing: 5) {
                        Spacer()
                        
                        Blur(.systemChromeMaterialLight)
                            .frame(height: 17)
                            .mask(
                                HStack{
                                    Spacer()
                                    Text("paid tweaks".uppercased())
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                            )
                        Text("Don't Pirate Tweaks.\nSupport Developers.")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                        ModalLink(destination: Text("Modal")) {
                            LongButton("Browse Paid Tweaks")
                                .padding(.top, 15)
                        }
                        
                        Blur(.systemChromeMaterialLight)
                            .frame(height: 17)
                            .mask(
                                HStack{
                                    Spacer()
                                    Text("No in-app purchases. Obviously.")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                            )
                            .padding(.vertical, 15)
                    }
                    
                    // Profile Pic
                    VStack {
                        HStack {
                            Spacer()
                            ModalLink(
                                destination: { AccountView(dismiss: $0).environmentObject(self.user) },
                                label: { SmallProfile() }
                            )
                        }
                        Spacer()
                    }
                        .padding(.trailing, 20)
                        .padding(.top, 50)
                }.frame(height: 600)
                
                // Content
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Popular Free Tweaks")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(destination: FullScreenList(Constants.tweakLists.free)) {
                            Text("See All")
                                .foregroundColor(.teal)
                        }
                    }
                    
                    ForEach(Constants.tweakLists.free) { tweak in
                        HStack {
                            NavigationLink(destination: TweakView(tweak: tweak)) {
                                tweak.getIcon(size: 60)
                            }.buttonStyle(NoReactionButtonStyle())
                            HStack {
                                NavigationLink(destination: TweakView(tweak: tweak)) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(tweak.name)
                                            .font(.body)
                                        Text(tweak.shortDesc)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }.buttonStyle(NoReactionButtonStyle())
                                Spacer()
                                ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: tweak).environmentObject(self.user)}) {
                                    SmallButton(tweak.getPrice())
                                }.buttonStyle(InstallButtonStyle())
                            }
                        }
                    }
                }
                .padding(20)
            }
        }.onAppear(perform: {})
    }
}

struct LongButton: View {
    public var text: String
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            Color.teal
            
            Text(self.text)
                .font(.footnote)
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
            .frame(width: 270, height: 45)
            .cornerRadius(10)
    }
}

struct Tweaks_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            NavigationView {
                Tweaks().environmentObject(User())
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}
