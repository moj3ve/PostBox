//
//  Home.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct NullView: View {
    var body: some View {
        Color.white.frame(width: 0, height: 0)
    }
}

struct Home: View {
    @State private var flow = [
        ["Reasons to jailbreak", "App Theming", "Change the way your app icons appear", "banner1.1", ""],
        ["Reasons to jailbreak", "iMessage Theming", "Re-design your message bubbles", "banner2", ""],
    ]
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack(alignment: .center, spacing: 30) {
                HomeNavBar().zIndex(1)
                
                ForEach(self.flow, id: \.self) { card in
                    NavigationLink(destination:
                        StoryView(card)
                    ) {
                        if card[4] == "none" {
                            BannerCardFull(card, image: card[3])
                        } else {
                            BannerCard(card, image: card[3])
                        }
                    }.buttonStyle(CardButtonStyle())
                        
                }
                
                CardList(Constants.tweakLists.long, subhead: "Jailbreak Tweaks", title: "Tweaks you can't\nsee, but can feel")
                CardList(Constants.tweakLists.long, subhead: "Hand Picked", title: "Essential\nCosmetic Tweaks")
                
            }.padding(.bottom, 40)
        }
    }
}


struct HomeNavBar: View {
    @EnvironmentObject var user: User
    private var dateText: String
    
    // Needs to generate date
    init() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        print(formatter.string(from: date))
        self.dateText = formatter.string(from: date).uppercased()
    }
    
    var body: some View {
        HStack {
            // Today and date text
            VStack(alignment: .leading, spacing: 10) {
                Text(self.dateText)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.lightgray)
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            // Pushes elements to the side
            Spacer()
            
            // Small Profile Pic Button
            VStack {
                Spacer()
                ModalLink(destination: {AccountView(dismiss: $0).environmentObject(self.user).accentColor(.teal)}) {
                    SmallProfile()
                }
            }
        }
        .padding(.top, 25)
        .padding(.horizontal, 20)
    }
}

struct SmallProfile: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Image(self.user.img)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 35, height: 35)
            .clipShape(Circle())
    }
}

struct InfoButton: View {
    var body: some View {
        Image(systemName: "info.circle")
            .font(.system(size: 20))
            .accentColor(Color.teal)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModalPresenter {
                Home()
                    .environmentObject(User())
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }.environment(\.colorScheme, .dark)
    }
}
