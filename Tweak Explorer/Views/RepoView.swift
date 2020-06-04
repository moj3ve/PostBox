//
//  RepoView.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/3/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct RepoView: View {
    public var repo: Repo
    public var dismiss: () -> ()
    
    var body: some View {
        ZStack {
            repo.getBanner()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.maxX)
                .edgesIgnoringSafeArea(.bottom)
            
            Button (action: self.dismiss) {
                CloseModalButton()
            }
            
            VStack (alignment: .leading, spacing: 20) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("ADD REPO")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.6)
                        .padding(.bottom, 5)
                    
                    Text(self.repo.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }.padding(.horizontal, 10)
                
                HStack {
                    Text(self.repo.url)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    Spacer()
                    SmallButton("ADD")
                        .padding(.horizontal, 15)
                }
                .frame(height: 50)
                .background(Blur(.systemThinMaterial))
                .cornerRadius(9)
            }.padding(.horizontal, 20)
        }
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(destination: {RepoView(repo: Database.repos["packix"]!, dismiss: $0)}) {
                Text("Click Here")
            }
        }
    }
}

struct CloseModalButton: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Blur(.systemMaterial)
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
            Spacer()
        }
        .padding(20)
        .zIndex(1)
    }
}
