//
//  Tweak.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/2/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation
import SwiftUI

class Tweak: Identifiable, Comparable {
    /// Basic data: `id` (name), `repo`, `shortDesc`, `longDesc` Arguments: `name`, `repo`, `shortDesc`, `longDesc`, `type`, `price`
    public var id: String
    public var name: String
    public var dev: String
    public var repo: String
    public var repoWithProtocol: String
    public var shortDesc: String
    
    /// Tweak = `"tweak"` | Theme = `"theme"` | Application = `"app"` | Widget = "widget"
    public var type: String = "tweak"
    public var price: Double = 0
    
    /// Arguments: `name`, `repo`, `shortDesc`, `longDesc`, `type`, `price`
    init(name: String? = nil, dev: String? = nil, repo: String? = nil, shortDesc: String? = nil, type: String? = nil, price: Double? = nil) {
        let possibleName = name ?? "Unknown Tweak"
        
        self.id = possibleName.lowercased().replacingOccurrences(of: " ", with: "_")
        self.name = possibleName
        self.repo = repo?.replacingOccurrences(of: "https://", with: "") ?? "Unknown Repo"
        self.shortDesc = shortDesc ?? "Awesome tweak"
        self.type = type ?? "tweak"
        self.price = price ?? 0
        self.repoWithProtocol = repo ?? ""
        self.dev = dev ?? "Unknown Developer"
    }
    
    static func == (lhs: Tweak, rhs: Tweak) -> Bool {
        return lhs.getTweakID() == rhs.getTweakID()
    }

    static func < (lhs: Tweak, rhs: Tweak) -> Bool {
        return lhs.getTweakID() < rhs.getTweakID()
    }
    
    static func > (lhs: Tweak, rhs: Tweak) -> Bool {
        return lhs.getTweakID() > rhs.getTweakID()
    }
    
    /// Returns an ID of type `String`
    public func getTweakID() -> String {
        return self.name.lowercased()
            .replacingOccurrences(of: " ", with: "_")
    }
    
    /// Returns a formatted price of type `String`. Either `"FREE"` or  some `Double`.
    public func getPrice(_ free: String? = nil) -> String {
        let freeText = free ?? "GET"
        return self.price == 0 ? freeText : "$" + String(format: "%.2f", self.price)
    }
    
    /// Returns `String` of the tweak's icon name.
    public func getIconName() -> String {
        var fileID = self.getTweakID() + "_icon"
        if UIImage(named: fileID) == nil {
            fileID = "tweak_icon"
        }
        return fileID
    }
    
    /// Returns `some View` of the tweak's icon.
    public func getIcon(size: CGFloat) -> some View {
        let fileID = self.getIconName()
        
        return Image(fileID).resizable()
            .renderingMode(.original)
            .frame(width: size, height: size)
            .cornerRadius(CGFloat((13.0/57.0) * Double(size)))
    }
    
    /// Returns Full Card Image
    public func getFull() -> some View {
        var imageName = getTweakID() + "_full"
        if (UIImage(named: imageName) == nil) {
            imageName = getTweakID() + "_ss_1"
            if (UIImage(named: imageName) == nil) {
                imageName = "tweak_full"
            }
        }
        
        return Image(imageName).resizable().aspectRatio(contentMode: .fill)
    }
    
    /// Returns a screenshot of given `frameSize`
    public func getScreenshot(_ i: Int) -> String {
        let imageName = "\(getTweakID())_ss_\(i)"
        return UIImage(named: imageName) == nil ? "none" : imageName
    }
    
    /// Returns and HStack of screenshots
    public func getScreenshots(_ multiplyer: Double = 1.0) -> some View {
        var i = 1
        while (UIImage(named: getScreenshot(i)) != nil) {i += 1}
        
        return HStack (spacing: 20) {
            ForEach(1..<i) { i in
                Image(self.getScreenshot(i)).resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: CGFloat(216*multiplyer), height: CGFloat(468*multiplyer))
                    .cornerRadius(15)
            }
        }.padding(.horizontal, 20)
    }
    
    /// Returns the tweak's banner image name
    public func getBanner() -> String {
        let bannerName = getTweakID() + "_banner"
        return UIImage(named: bannerName) == nil ? "tweak_banner" : bannerName
    }
    
    public func getLongDesc() -> some View {
        let desc = Database.descs[self.getTweakID()]!
        
        return MarkdownParser(string: "\(self.shortDesc)@@ " + desc).getView()
    }
}
