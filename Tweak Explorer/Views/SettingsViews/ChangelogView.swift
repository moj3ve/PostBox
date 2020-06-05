//
//  ChangelogView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/5/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView
import MDText

struct ChangelogView: View {
    var dismiss: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(changelog.components(separatedBy: "\n\n---\n\n"), id: \.self) { version in
                    VStack {
                        MDText(markdown: version)
                            .lineSpacing(10)
                            .padding(20)
                        Divider()
                    }
                }
                    
                Spacer()
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
