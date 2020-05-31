//  StoryView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.

import SwiftUI

struct StoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var show = false
    
    public var headingText: [String]
    
    init(_ headingText: [String]) {
        self.headingText = headingText
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Image | Title
                    Banner(self.headingText, image: "banner1.1")
                    
                    // Content
                    VStack(alignment: .center, spacing: 40) {
                        Paragraph(first: "Theming is a fundamental feature", "of iOS jailbreaking. Most know that iOS heavily restricts the user from customizing the interface; However, jailbreaking solves that problem.")
                        Paragraph(first: "Theming is a fundamental feature", "of iOS jailbreaking. Most know that iOS heavily restricts the user from customizing the interface; However, jailbreaking solves that problem.")
                        Paragraph(first: "Theming is a fundamental feature", "of iOS jailbreaking. Most know that iOS heavily restricts the user from customizing the interface; However, jailbreaking solves that problem.")
                        Paragraph(first: "Theming is a fundamental feature", "of iOS jailbreaking. Most know that iOS heavily restricts the user from customizing the interface; However, jailbreaking solves that problem.")
                        Paragraph(first: "Theming is a fundamental feature", "of iOS jailbreaking. Most know that iOS heavily restricts the user from customizing the interface; However, jailbreaking solves that problem.")
                        Paragraph(first: "Theming is a fundamental feature", "of iOS jailbreaking. Most know that iOS heavily restricts the user from customizing the interface; However, jailbreaking solves that problem.")
                    }.padding(20)
                    Spacer()
                }.padding(.bottom, 90)
            }
            //BackButton()
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


struct BackButton: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Blur(.systemChromeMaterialLight)
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
            NavigationLink(destination: StoryView(text)) {
                BannerCard(text)
            }
        }
    }
}
