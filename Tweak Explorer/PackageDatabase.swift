//
//  PackageDatabase.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/30/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation

struct PackageDatabase {
    static let desc = """
        Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

        Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

        Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
        """

    // To fully enjoy this section below, toggle Preferences > Text Editing > Code Folding Ribbon on and fold all tweaks.
    static let database: [String: Tweak] = [
        "jellyfish"     : Tweak(
            name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 1.99),
        "snowboard"     : Tweak(
            name: "SnowBoard", dev: "Spark Dev", repo: "sparkdev.me", shortDesc: "Snowboard theming engine.", longDesc: desc, type: "tweak", price: 0),
        "cylinder"      : Tweak(
            name: "Cylinder", dev: "R33d", repo: "https://repo.packix.com", shortDesc: "Make your icons dance.", longDesc: desc, type: "tweak", price: 0),
        "lockplus_pro"  : Tweak(
            name: "Lockplus Pro", dev: "Junesiphone", repo: "https://junesiphone.com/supersecret", shortDesc: "Modernize your lockscreen.", longDesc: desc, type: "tweak", price: 5.00),
        "portrait_xi"   : Tweak(
            name: "Portrait XI", dev: "Fortfoxmobile", repo: "https://repo.packix.co", shortDesc: "Single camera portait mode.", longDesc: desc, type: "tweak", price: 4.99),
        "xen_html"      : Tweak(
            name: "Xen HTML", dev: "Matt Clarke", repo: "https://repo.packix.com", shortDesc: "Xen HTML allows for displaying widgets on both the iOS Lockscreen and Homescreen.", longDesc: desc, type: "tweak", price: 0),
        "activator"     : Tweak(
            name: "Activator", dev: "Ryan Petrich", repo: "https://rpetri.ch/repo", shortDesc: "Centralized gestures, button and shortcut management for iOS.", longDesc: desc, type: "tweak", price: 0),
        "kalm"          : Tweak(
            name: "Kalm", dev: "UBIK", repo: "https://repo.chariz.com", shortDesc: "A beautiful first sight.", longDesc: desc, type: "tweak", price: 0.99),
    ]
}
