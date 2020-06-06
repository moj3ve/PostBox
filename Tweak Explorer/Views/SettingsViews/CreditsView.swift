//
//  CreditsView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/5/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct CreditsView: View {
    @State var offset = CGSize.zero
    var dismiss: () -> ()
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                Group {
                    Text(offset == CGSize.zero ? "@b0kch01" : "Developer").fontWeight(.semibold).font(.title)
                    Text("&").fontWeight(.bold)
                    Text(offset == CGSize.zero ? "@polarizz" : "Designer").fontWeight(.semibold).font(.title)
                }
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: offset == CGSize.zero ? 0 : 4)
                .animation(.none)
            }
            
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .background(Color.teal)
            .cornerRadius(125)
            .shadow(color: Color.gray.opacity(0.7), radius: 20)
            .foregroundColor(Color(.systemBackground))
            .offset(x: offset.width, y: offset.height)
            .scaleEffect(offset == CGSize.zero ? 1 : 0.8)
            .animation(.spring(response: 0.6, dampingFraction: 0.5))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }

                    .onEnded { _ in
                        self.offset = .zero
                    }
            )
        }
        .navigationBarTitle("Credits", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: self.dismiss) {
                Text("Done").fontWeight(.medium)
        })
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink (destination: { Settings(dismiss: $0).environmentObject(User()) }) {
                Text("Teleport.")
            }
        }
    }
}
