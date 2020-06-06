//
//  Parser.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/5/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation
import SwiftUI

class MarkdownParser {
    public var input: String
    
    init(string: String) {
        self.input = string
    }
    
    func getView() -> some View {
        var elementList = [MarkdownElement]()
        
        let inputList = input.components(separatedBy: "\n")
        for line: String in inputList {
            if line.starts(with: "# ") {
                elementList.append(MarkdownElement(type: "heading", inputs: [String(line.dropFirst(2))]))
            }
            
            else if line.starts(with: "## ") {
                elementList.append(MarkdownElement(type: "subheading", inputs: [String(line.dropFirst(3))]))
            }
                
            else if line.starts(with: "!| ") {
                elementList.append(MarkdownElement(type: "image", inputs: line.dropFirst(3).components(separatedBy: " | ")))
            }
                
            else if line.starts(with: "    * ") {
                elementList.append(MarkdownElement(type: "list", inputs: [String(line.dropFirst(6))]))
            }
                
            else if line == "---" {
                elementList.append(MarkdownElement(type: "divider", inputs: []))
            }
            
            else {
                elementList.append(MarkdownElement(type: "text", inputs: [line]))
            }
        }
        
        return HStack {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(elementList, id: \.self) { element in
                    element
                }
            }
            Spacer()
        }
    }
}

struct MarkdownElement: View, Hashable {
    var type: String
    var inputs: [String]
    
    func getTextComponents() -> [String] {
        return inputs[0].components(separatedBy: "@@")
    }
    
    var body: some View {
        Group {
            if type == "text" {
                if (getTextComponents().count == 1) {
                    Text(getTextComponents()[0])
                        .foregroundColor(.gray)
                } else {
                    Text(getTextComponents()[0])
                        .fontWeight(.semibold)
                    + Text(getTextComponents()[1])
                        .foregroundColor(.gray)
                }
            }
                
            else if type == "list" {
                HStack (alignment: .top){
                    Circle()
                        .foregroundColor(.primary)
                        .frame(width: 5, height: 5)
                        .padding(.leading, 20)
                        .padding(.vertical, 7.5)
                    Text(inputs[0])
                }
            }

            else if type == "heading" {
                Text(inputs[0]).font(.title).fontWeight(.semibold)
            }
                
            else if type == "subheading" {
                Text(inputs[0]).font(.system(size: 20)).bold().foregroundColor(.secondary)
            }

            else if type == "image" {
                VStack(spacing: 0) {
                    Image(inputs[0]).resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        Text(inputs[1])
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(15)
                    .background(Color(.secondarySystemBackground))
                }
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, y: 10)
            }
            
            else if type == "divider" {
                Divider().padding(.vertical, 20)
            }
        }
    }
}

struct Markdown_Preview: PreviewProvider {
    static var previews: some View {
        let p = MarkdownParser(string: changelog)
        
        return p.getView().padding(20)
    }
}
