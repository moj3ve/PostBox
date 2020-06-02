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
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack(alignment: .center, spacing: 30) {
                HomeNavBar().zIndex(1)

                NavigationLink(destination:
                    // If you get a random error, try putting ! in the back
                    StoryView(Database.stories["app_theming"]!)
                ) {
                    BannerCard(Database.stories["app_theming"]!)
                    // Follow the init of storyview and move to bannercard / bannercardfull
                    
                }.buttonStyle(CardButtonStyle())
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
            VStack(alignment: .leading, spacing: 3) {
                Text(self.dateText)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.lightgray)
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Spacer()
            
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
