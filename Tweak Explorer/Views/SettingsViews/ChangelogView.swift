//
//  ChangelogView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/5/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

struct ChangelogView: View {
    var dismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                Banner(["ABOUT THE APP", "Changelog", "Latest changes, known issues, and more."], image: "banner4", inModal: true)
                MarkdownParser(string: changelog).getView().padding(20)
            }
        }
            .frame(width: UIScreen.main.bounds.maxX)
            .navigationBarTitle("Changelog", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: self.dismiss) {
                Text("Done").fontWeight(.medium)
        })
    }
}

struct ChangelogView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresenter {
            ModalLink(
                destination: { Settings(dismiss: $0).environmentObject(User()) },
                label: { SmallProfile().environmentObject(User()) }
            )
        }
    }
}
