//
//  TweakView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/27/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//
import SwiftUI
import ModalView

struct TweakView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var openShareSheet = false
    
    public var tweak: Tweak
    
    // Sharesheet
    func shareURL() {
        openShareSheet.toggle()
        
        let string = "Check out this cool \(self.tweak.type) by \(self.tweak.dev)! \n[\(self.tweak.getPrice("Free"))] \(self.tweak.name) - \(self.tweak.shortDesc) "
        let activityView = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // Banner Image
                if (self.tweak.getBanner() != "none") {
                    Banner([], image: self.tweak.getBanner(), bannerHeight: 200) .edgesIgnoringSafeArea(.all)
                }
                // Content
                VStack {
                    
                    // ICON | Title | Subheading | Button | Share
                    HStack (spacing: 20){
                        tweak.getIcon(size: 120)
                        VStack (alignment: .leading, spacing: 10) {
                            Group {
                                Text(self.tweak.name) // Title
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                + Text("\n" + self.tweak.shortDesc) // Subtitle
                                    .font(.callout)
                                    .foregroundColor(.lightgray)
                            }
                                .lineLimit(3)
                            
                            HStack {
                                ModalLink(destination: {RepoPrompt(dismiss: $0, tweak: self.tweak)}) {
                                    SmallButton(self.tweak.getPrice())
                                }
                                Spacer()
                                Button(action: {self.shareURL()}) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 20))
                                }
                            }
                        }.frame(height: 120)
                    }.padding(20)
                    
                    Divider().padding(.horizontal, 20)
                    
                    HStack(spacing: 10) {
                        Group {
                            Text("Type: ")
                                .font(.headline)
                                .foregroundColor(.lightgray)
                                .fontWeight(.semibold)
                            + Text(self.tweak.type.firstUppercased)
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        Text(tweak.dev)
                            .font(.headline)
                            .foregroundColor(.teal)
                            .fontWeight(.bold)
                        
                    }.padding(20)
                    
                    ModalLink (destination: {FullImageView(dismiss: $0, tweak: self.tweak)}) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            self.tweak.getScreenshots()
                        }
                    }.buttonStyle(NoReactionButtonStyle())
                    
                    Divider().padding(20)
                    
                    
                    VStack (spacing: 20) {
                        HStack {
                            Text("Description")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.teal)
                            Spacer()
                        }
                        tweak.getLongDesc()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    
                    Divider().padding(20)
                    
                    VStack {
                        tweak.getIcon(size: 100)
                        Text(tweak.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ModalLink(destination: {RepoPrompt(dismiss: $0, tweak: self.tweak)}) {
                            SmallButton(self.tweak.getPrice())
                        }
                    }.padding(.bottom, 150)
                }
            }
        }
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .accentColor(.teal)
            .navigationBarTitle("", displayMode: .large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {self.mode.wrappedValue.dismiss()}){
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.teal)
            })
    }
}

struct FullImageView: View {
    var dismiss: () -> ()
    var tweak: Tweak
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ScrollView(.horizontal, showsIndicators: false) {
                    tweak.getScreenshots(1.4)
                }.padding(.top, 20)
            }
            .navigationBarTitle(Text(tweak.name), displayMode: .inline)
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
}

struct TweakView_Previews: PreviewProvider {
    static let desc = """
        Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

        Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

        Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
        """
    
    static var previews: some View {
        ModalPresenter {
            NavigationView {
                NavigationLink(destination: TweakView(tweak:

                    Tweak(
                        name: "Jellyfish",
                          dev: "Dynastic",
                          repo: "https://repo.dynastic.co",
                          shortDesc: "Modernize your lockscreen.",
                          longDesc: desc,
                          type: "tweak",
                          price: 0.99))
                    ) {

                    Text("Click me to go there.")
                }
            }
        }
    }
}
