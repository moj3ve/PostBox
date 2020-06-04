//
//  Repo.swift
//  Tweak Explorer
//
//  Created by Paul Wong on 6/3/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation
import SwiftUI

class Repo: Identifiable, Comparable {
    public var id: String
    public var name: String
    public var url: String
    public var urlNoProtocol: String
    
    init (_ name: String, url: String) {
        self.id = name.lowercased().replacingOccurrences(of: " ", with: "_")
        self.name = name
        self.url = url
        self.urlNoProtocol = url.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "https://", with: "")
    }
    
    /// Compare functions
    static func == (lhs: Repo, rhs: Repo) -> Bool {
        return lhs.getRepoID() == rhs.getRepoID()
    }

    static func < (lhs: Repo, rhs: Repo) -> Bool {
        return lhs.getRepoID() < rhs.getRepoID()
    }
    
    static func > (lhs: Repo, rhs: Repo) -> Bool {
        return lhs.getRepoID() > rhs.getRepoID()
    }
    
    public func getRepoID() -> String {
        return name.lowercased().replacingOccurrences(of: " ", with: "_")
    }
    
    public func getIcon(size: CGFloat) -> some View {
        var fileID = self.getRepoID() + "_icon"
        if UIImage(named: fileID) == nil {
            fileID = "tweak_icon"
        }
        
        return Image(fileID).resizable()
            .renderingMode(.original)
            .frame(width: size, height: size)
            .cornerRadius(CGFloat((13.0/57.0) * Double(size)))
    }
    
    public func getBanner() -> some View {
        var fileID = self.getRepoID() + "_banner"
        if UIImage(named: fileID) == nil {
            fileID = "tweak_icon"
        }
        
        return Image(fileID).resizable()
            .renderingMode(.original)
        
    }
    
    public func getTweaks() -> [Tweak] {
        let db = Database.packages
        
        var tweaksList = [Tweak]()
        for tweak in Array(db.values) {
            if tweak.repoWithProtocol == self.url {
                tweaksList.append(tweak)
            }
        }
        
        return tweaksList
    }
}
