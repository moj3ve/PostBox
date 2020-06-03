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
    public var content = [StoryElement]()
    
    init(_ header: [String], img: String? = nil, blurred: Bool = true, input: [[String]]) {
        self.header = header
        self.id = header[1].lowercased().replacingOccurrences(of: " ", with: "_")
        self.img = img ?? "banner1.1"
        self.blurred = blurred
        
        for str in input {
            self.content.append(StoryElement(str))
        }
    }
}

class StoryElement {
    public var type = "unknown"
    public var content: [String]
    
    init(_ info: [String]) {
        if info[0] == "p" {
            self.type = "text"
        } else if info[0] == "i" {
            self.type = "image"
        }
        
        self.content = info
     }
    
    func getElement() -> some View {
        if self.type == "p" {
            return StoryBlock(first: content[1], content[2], image: false)
        } else {
            return StoryBlock(first: content[1], content[2], image: true)
        }
    }
}
