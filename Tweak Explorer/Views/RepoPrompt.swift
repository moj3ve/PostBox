//
//  RepoView.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/3/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct RepoPrompt: View {
    @State var popup = false
    public var dismiss: () -> ()
    public var repo: Repo
    
    var body: some View {
        ZStack {
            Image(repo.getIconName()).resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.05)
                .frame(width: UIScreen.main.bounds.maxX)
                .edgesIgnoringSafeArea(.bottom)
                .brightness(-0.15)
                .blur(radius: 20)
                .frame(width: UIScreen.main.bounds.maxX)
            
            
            CloseModalButton(dismiss: self.dismiss)
            
            
            VStack (alignment: .leading, spacing: 20) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("ADD REPO")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .opacity(0.6)
                        .padding(.bottom, 5)
                    
                    Text(self.repo.name)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }.padding(.horizontal, 10)
                
                HStack {
                    Text(self.repo.url)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    Spacer()
                    SmallButton("ADD")
                        .padding(.horizontal, 15)
                }
                    .frame(height: 50)
                    .background(Blur(.systemThinMaterial))
                    .cornerRadius(9)
                    .offset(y: self.popup ? 0 : 200)
                    .onAppear(perform: {self.popup.toggle()})
                    .animation(.spring(response: 1), value: self.popup)
            }.padding(20)
        }
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(destination: {RepoPrompt(dismiss: $0, repo: Database.repos["packix"]!)}) {
                Text("Click Here")
            }
        }
    }
}

struct CloseModalButton: View {
    var dismiss: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: self.dismiss) {
                    Blur(.systemChromeMaterialLight)
                        .frame(width: 50, height: 50)
                        .mask(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 30))
                                    Spacer()
                                }
                                Spacer()
                            }
                        )
                }
            }
            Spacer()
        }
        .padding(20)
        .zIndex(1)
    }
}
