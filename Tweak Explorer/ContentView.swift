//
//  ContentView.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI
import ModalView

/// Custom `Tweak` class.
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
    
    /// Returns `some View` of the tweak's icon.
    public func getIcon(size: CGFloat) -> some View {
        var fileID = self.getTweakID() + "_icon"
        if UIImage(named: fileID) == nil {
            fileID = "tweak_icon"
        }
        
        return Image(fileID).resizable()
            .renderingMode(.original)
            .frame(width: size, height: size)
            .cornerRadius(CGFloat((10.0/57.0) * Double(size)))
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
        return UIImage(named: bannerName) == nil ? "none" : bannerName
    }
    
    public func getLongDesc() -> some View {
        let blocks = PackageDatabase.descs[self.getTweakID()]!.components(separatedBy: "\n\n")
        let first = Paragraph(first: self.shortDesc, blocks[0])
        
        return VStack(spacing: 40) {
            first
            ForEach(2...blocks.count, id: \.self) { text in
                Paragraph(blocks[text - 1])
            }
        }
    }
}

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
            wishes.append(PackageDatabase.database[id]!)
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


struct ContentView: View {
    var body: some View {
        ModalPresenter {
            TabView {
                NavigationView {
                    Home()
                        .navigationBarTitle("Home", displayMode: .inline)
                        .navigationBarHidden(true)
                }
                    .tabItem { VStack {
                        Image(systemName: "house.fill")
                        Text("Home")}
                    }
                
                NavigationView {
                    Tweaks()
                        .navigationBarTitle("Tweaks", displayMode: .inline)
                        .navigationBarHidden(true)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "cube.box.fill")
                        Text("Tweaks")
                    }
                }
                Text("Repo")
                    .tabItem {
                        VStack {
                            Image(systemName: "folder.fill")
                            Text("Repo")
                        }
                }
                Text("Search")
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                }
            } // TabView
        }.accentColor(.teal) // ModalPresenter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(User())
            .environment(\.colorScheme, .dark)
    }
}
