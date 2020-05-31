//
//  TestConstants.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/27/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

struct Constants {
    static let db: [String: Tweak] = PackageDatabase.database
    static let desc = """
        Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

        Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

        Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
        """
    
    struct tweak {
        static let desc = """
        Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

        Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

        Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
        """
        
        static let free = Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0)
        static let paid = Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0.99)
        
    }
    
    struct tweakLists {
        static let paid = [
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 2.50),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 2.50),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 2.50),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 2.50),
        ]
        
        static let free = [
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0),
        ]
        
        static let mix = [
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 1.00),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 4.50),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0),
            Tweak(name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 0.99),
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
