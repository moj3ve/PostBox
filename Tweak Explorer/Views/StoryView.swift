//  StoryView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.

import SwiftUI

struct StoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var openShareSheet = false
    
    var story: Story

    init(_ story: Story) {
        self.story = story
    }
    
    func shareURL() {
        openShareSheet.toggle()
        
        let string = story.header[0]
        let activityView = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Image | Title
                    self.story.getBanner()
                    
                    // Content
                    VStack(alignment: .center, spacing: 30) {
                        self.story.getContent()
                        Divider()
                        Button(action: shareURL) {
                            LongShareButton("Share Story")
                                .padding(.vertical, 40)
                        }
                    }.padding(20)
                    Spacer()
                }.padding(.bottom, 90)
            }
        }
        .accentColor(.teal)
        .navigationBarHidden(false)
        .navigationBarTitle("", displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {self.mode.wrappedValue.dismiss()}){
                BackButton()
        })
        .edgesIgnoringSafeArea(.all)
    } // body
}


struct BackButton: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Blur(.systemMaterial)
                    .overlay(Color(UIColor.secondaryLabel).opacity(0.4))
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

struct LongShareButton: View {
    public var text: String
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            Color.teal
            
            Text(self.text)
                .font(.subheadline)
                .foregroundColor(.white)
                .fontWeight(.medium)
        }
            .frame(width: 270, height: 45)
            .cornerRadius(10)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var text = ["Reasons to jailbreak", "App Theming", "Change the way your app icons appear."]
    static var previews: some View {
        NavigationView {
            NavigationLink(destination: StoryView(Database.stories["app_theming"]!)) {
                BannerCard(Database.stories["app_theming"]!)
            }
        }
    }
}
