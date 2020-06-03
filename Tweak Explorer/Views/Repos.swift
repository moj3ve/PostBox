//
//  Repos.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/2/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

//import SwiftUI
//import ModalView
//
//struct Repos: View {
//    var body: some View {
//        NavigationView {
//            ScrollView(showsIndicators: true) {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    RepoCard(Database.repos["packix"]!)
//                    .cornerRadius(15)
//                }.padding(20)
//
//            }
//            .navigationBarTitle("Featured")
//        }
//    }
//}
//
//struct RepoCard: View {
//    public var repoText: [String]
//    public var repoImg: String
//    public var repoCardHeight: CGFloat
//    public var repoIsBlurred: Bool
//    private var repoHideText: Bool
//
//    init (_ repotitle: [[String]], repoCardHeight: CGFloat? = nil) {
//        let repoInfo = repotitle[0]
//
//        self.repoText = repoInfo
//        self.repoImg = repoInfo[3]
//        self.repoIsBlurred = repoInfo[4] == "true"
//        self.repoCardHeight = 240
//        self.repoHideText = repoInfo.count == 0
//    }
//
//    var body: some View {
//        ZStack {
//            Image(self.repoImg).resizable()
//            .renderingMode(.original)
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 313, height: self.repoCardHeight)
//
//            if (!self.repoHideText) {
//                if (self.repoIsBlurred) {
//                    VStack {
//                        Spacer()
//                        HStack {
//                            VStack (alignment: .leading) {
//                                Text(repoText[0].uppercased())
//                                    .font(.subheadline)
//                                    .fontWeight(.semibold)
//                                    .opacity(0.6)
//                                Text(repoText[1])
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                Text(repoText[2])
//                                    .font(.caption)
//                                    .fontWeight(.semibold)
//                                    .padding(.top, 5)
//                                    .opacity(0.6)
//                            }.padding(20)
//                            Spacer()
//                        }
//                        .background(Blur(.systemChromeMaterial))
//                    }
//                } else {
//                    ZStack {
//                        HStack {
//                            VStack (alignment: .leading) {
//                                Spacer()
//                                Text(repoText[0].uppercased())
//                                    .font(.subheadline)
//                                    .fontWeight(.semibold)
//                                Text(repoText[1])
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                Text(repoText[2])
//                                    .font(.caption)
//                                    .fontWeight(.semibold)
//                                    .padding(.top, 10)
//                            }
//                            Spacer()
//                        }.padding(20).foregroundColor(.white)
//                    }
//                }
//            }
//
//
//
//
//
//        }
//
//
//    }
//
//    
//
//}
//
//struct Repos_Previews: PreviewProvider {
//    static var previews: some View {
//        Repos()
//    }
//}
