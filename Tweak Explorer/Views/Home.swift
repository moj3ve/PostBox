//
//  Home.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct Home: View {
    @State var showTop = false
    
    private func updateTop(_ g: GeometryProxy) -> some View {
        self.showTop = g.frame(in: .global).minY <= 15
        return Rectangle()
    }
    
    var body: some View {
        GeometryReader { g in
            Blur(.systemChromeMaterial)
                .frame(width: UIScreen.main.bounds.maxX, height: g.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.all)
                .zIndex(2)
                .opacity(self.showTop ? 1 : 0)
                .animation(.easeIn(duration: 0.2), value: self.showTop)
            
            ScrollView(showsIndicators: true) {
                VStack(spacing: 0) {
                    GeometryReader { g2 in
                        self.updateTop(g2)
                        }.frame(width: 0, height: 0).padding(0)
                    VStack(alignment: .center, spacing: 30) {
                        HomeNavBar().zIndex(1)
                        
                        NavigationLink(destination:
                            StoryView(Database.stories["app_theming"]!)
                        ) {
                            BannerCard(Database.stories["app_theming"]!)
                        }.buttonStyle(CardButtonStyle())
                        
                        
                        CardList(Constants.tweakLists.long, subhead: "Jailbreak Tweaks", title: "Tweaks you can't\nsee, but can feel").buttonStyle(CardButtonStyle())
                        CardList(Constants.tweakLists.long, subhead: "Hand Picked", title: "Essential\nCosmetic Tweaks")
                        .buttonStyle(CardButtonStyle())
                        
                    }
                }.padding(.bottom, 60)
            }
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
                ModalLink(destination: {Settings(dismiss: $0).environmentObject(self.user).accentColor(.teal)}) {
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
                Home().environmentObject(User())
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
