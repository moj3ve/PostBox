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
    public var image: String
    
    init(_ headingText: [String], image: String? = nil) {
        self.headingText = headingText
        self.image = image ?? "banner1.1"
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Image | Title
                    Banner(self.headingText, image: self.image)
                    
                    // Content
                    VStack(alignment: .center, spacing: 30) {
                        Paragraph(first: "Unlike Android, Apple", "doesn't provide any default theming options to their devices. Although limited icon theming is possible with an unjailbroken device, many users have found out that the process is highly inefficient. With jailbreaking, users are able to unlock the full potentials of icon theming.")
                        Paragraph("With appropriate themeing engines such as SnowBoard, Anemone, or iThemer, users can easily change the appearance of app icons, notification badges, dock labels, and even system glyphs.")
                        Paragraph("As more and more devices are becoming eligible to jailbreaking, develops and designers race to create the ideal themes to appeal their customers. With thousands of theming packages that alters the appearances of the majority of iOS apps, theming can allow devices to stand unique to others.")
                        LongShareButton("Share Story")
                        .padding(.top, 15)
                    }.padding(20)
                    Spacer()
                }.padding(.bottom, 100)
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

struct LongShareButton: View {
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
