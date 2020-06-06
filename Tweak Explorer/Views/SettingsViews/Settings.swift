//
//  UserPrefs.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct Settings: View {
    @EnvironmentObject var user: User
    @State var replay: Bool = !UserDefaults.standard.bool(forKey: "welcomed")
    
    var dismiss: () -> ()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: UserPrefs(dismiss: self.dismiss)) {
                        HStack(spacing: 15) {
                            Image(self.user.img).resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 58, height: 58)
                                .padding(.leading, 5)
                            VStack (alignment: .leading, spacing: 3) {
                                Text(self.user.name)
                                Text("Avid Jailbreaker")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: WishlistView(dismiss: self.dismiss)) {
                        Text("Wishlist")
                    }.padding(.leading, 5)
                }
                
                Section {
                    Toggle(isOn: $replay) {
                        Text("Replay Welcome Screen").padding(.leading, 5)
                    }
                    NavigationLink(destination: ChangelogView(dismiss: self.dismiss)) {
                        Text("Changelog")
                    }.padding(.leading, 5)
                    NavigationLink(destination: CreditsView(dismiss: self.dismiss)) {
                        Text("Credits")
                    }.padding(.leading, 5)
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: {
                UserDefaults.standard.set(!self.replay, forKey: "welcomed")
                self.dismiss()
            }) {
                Text("Done").fontWeight(.medium)
            })
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: { Settings(dismiss: $0).environmentObject(User()) },
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
