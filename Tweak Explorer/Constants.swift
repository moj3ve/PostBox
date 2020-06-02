//
//  TestConstants.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/27/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

struct Constants {
    static let db: [String: Tweak] = Database.packages
    static let desc = """
        Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

        Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

        Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
        """
    
    struct tweak {
        static let free = db["snowboard"]
        static let paid = db["jellyfish"]
    }
    
    struct tweakLists {
        static let pkgManagers = [
            db["cydia"]!,
            db[""],
        ]
        
        static let paid = [
            db["jellyfish"]!,
            db["lockplus_pro"]!,
            db["portrait_xi"]!,
            db["kalm"]!,
        ]
        
        static let free = [
            db["snowboard"]!,
            db["cylinder"]!,
            db["xen_html"]!,
            db["activator"]!,
        ]
        
        static let long: [Tweak] = [
            db["jellyfish"]!,
            db["snowboard"]!,
            db["cylinder"]!,
            db["lockplus_pro"]!,
            db["portrait_xi"]!,
            db["xen_html"]!,
            db["activator"]!,
            db["kalm"]!,
        ]

    }
}
