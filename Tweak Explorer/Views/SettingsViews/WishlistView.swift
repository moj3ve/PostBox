//
//  WishlistView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/5/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct WishlistView: View {
    @EnvironmentObject var user: User
    @State var sortMethod = 0
    
    var dismiss: () -> ()
    var sortMethods = ["Alphabetical", "Date"]
    
    var body: some View {
        ModalPresenter {
            ZStack {
                VStack {
                    Picker("Gender", selection: $sortMethod) {
                        ForEach(0..<sortMethods.count) {
                            Text(self.sortMethods[$0])
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(10)
                        .background(Blur(.systemMaterial))
                    
                    Spacer()
                }.zIndex(1)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(sortMethod == 0 ? self.user.getWishlist().sorted() : self.user.getWishlist()) { tweak in
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
                                        
                                        ModalLink(destination: {TweakPrompt(dismiss: $0, tweak: tweak)}) {
                                            SmallButton(tweak.getPrice())
                                        }.buttonStyle(InstallButtonStyle())
                                    }
                                        .frame(height: 100)
                                    Divider()
                                }
                            }.padding(.horizontal, 20)
                        }
                    }
                }.padding(.top, 80)
            }
                .navigationBarTitle("Wishlist", displayMode: .inline)
                .navigationBarItems(trailing: Button (action: {
                    self.dismiss()
            }) {Text("Done").fontWeight(.medium)})
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: {WishlistView(dismiss: $0).environmentObject(User())},
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
