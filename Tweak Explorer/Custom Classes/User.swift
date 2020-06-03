//
//  User.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 6/2/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation

class User: ObservableObject {
    @Published var img: String
    @Published var name: String
    @Published var wishlist: String
    
    var defaults = UserDefaults.standard
    
    init() {
        if (defaults.object(forKey: "stored_name") == nil) {
            defaults.set("Guest", forKey: "stored_name")
        }
        self.name = defaults.string(forKey: "stored_name")!
        
        if (defaults.object(forKey: "stored_pic") == nil) {
            defaults.set("generic", forKey: "stored_pic")
        }
        self.img = defaults.string(forKey: "stored_pic")!
        
        if (defaults.object(forKey: "wishlist") == nil) {
            defaults.set("", forKey: "wishlist")
        }
        self.wishlist = defaults.string(forKey: "wishlist")!
    }
    
    func saveName(_ new: String? = nil) {
        var updateText = new ?? ""
        
        if (updateText == "") {
            updateText = self.name
        } else {
            self.name = updateText
        }
        
        self.defaults.set(updateText, forKey: "stored_name")
    }
    
    func savePic(_ new: String? = nil) {
        var updateText = new ?? ""
        
        if (updateText == "") {
            updateText = self.img
        } else {
            self.img = updateText
        }
        
        self.defaults.set(updateText, forKey: "stored_pic")
    }
    
    private func addToWishlist(_ package: Tweak) {
        self.wishlist += package.getTweakID() + " "
    }
    
    private func removeFromWishlist(_ package: Tweak) {
        self.wishlist = self.wishlist.replacingOccurrences(of: package.getTweakID() + " ", with: "")
    }
    
    func inWishlist(_ package: Tweak) -> Bool {
        return self.wishlist.contains(package.getTweakID())
    }
    
    func getWishlist() -> [Tweak] {
        var wishlistIDs = self.wishlist.components(separatedBy: .whitespaces)
        _ = wishlistIDs.popLast()
        
        var wishes = [Tweak]()
        
        for id in wishlistIDs {
            wishes.append(Database.packages[id]!)
        }
        
        return wishes
    }
    
    func toggleWishlistItem(_ package: Tweak) {
        if (self.inWishlist(package)) {
            self.removeFromWishlist(package)
        } else {
            self.addToWishlist(package)
        }
        
        self.saveWishlist()
    }
    
    func saveWishlist() {
        self.defaults.set(self.wishlist, forKey: "wishlist")
    }
}
