//  StoryView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.

import SwiftUI

struct StoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    public var headingText: [String]
    public var image: String
    public var isBlurred: Bool
    public var flow: [[String]]
    

    init(_ story: [[String]]) {
        self.image = story[0][3]
        self.headingText = story[0]
        self.isBlurred = story[0][4] == "true"
        
        self.flow = story
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Image | Title
                    Banner(self.headingText, image: self.image)
                    
                    // Content
                    VStack(alignment: .center, spacing: 30) {
                        ForEach(1..<self.flow.count) { i in
                            // Paragraph Blocks
                            if (self.flow[i][0] == "p") {
                                Paragraph(first: self.flow[i][1], self.flow[i][2])
                            }
                            // Image Blocks
                            else if (self.flow[i][0] == "i"){
                                ImageBlock(image: self.flow[i][1], caption: self.flow[i][2])
                            }
                        }
                    }.padding(20)
                    Spacer()
                }.padding(.bottom, 90)
            }
        }
        .accentColor(.teal)
        .navigationBarTitle("", displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {self.mode.wrappedValue.dismiss()}){
                BackButton()
        })
        .edgesIgnoringSafeArea(.all)
    } // body
}

struct ImageBlock: View {
    var image: String
    var caption: String?=nil ?? ""
    
    var body: some View {
        VStack(spacing: 0) {
            Image(self.image).resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                Text(self.caption!)
                    .font(.callout)
                    .foregroundColor(.gray)
                Spacer()
            }
                .padding(20)
                .background(Color(.secondarySystemBackground))
        }.cornerRadius(10)
    }
}


struct BackButton: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Blur(.systemMaterial)
                    .overlay(Color(UIColor.label).opacity(0.4))
                    .frame(width: 30, height: 40)
                    .mask(
                        VStack {
                            Spacer()
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.system(size: 30))
                                
                            Spacer()
                        }
                )
                Spacer()
            }
            Spacer()
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var text = ["Reasons to jailbreak", "App Theming", "Change the way your app icons appear."]
    static var previews: some View {
        NavigationView {
            NavigationLink(destination: StoryView(Database.stories["app_theming"]!)) {
                BannerCard(text)
            }
        }
    }
}
