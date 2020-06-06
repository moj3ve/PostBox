//
//  Story.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/3/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation
import SwiftUI

class Story: Identifiable {
    public var id: String
    public var header: [String]
    public var img: String
    public var blurred: Bool
    public var input: String
    
    init(_ header: [String], img: String? = nil, blurred: Bool = true, input: String) {
        self.header = header
        self.id = header[1]
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")
        
        self.img = img ?? "banner1.1"
        self.blurred = blurred
        self.input = input
    }
    
    func getBanner() -> some View {
        return Group {
            if blurred {
                Banner(header, image: img)
            } else {
                BannerFull(header, image: img)
            }
        }
    }
    
    func getContent() -> some View {
        return MarkdownParser(string: input).getView()
    }
}
