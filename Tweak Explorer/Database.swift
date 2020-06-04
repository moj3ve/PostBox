//
//  PackageDatabase.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/30/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import Foundation

struct Database {
    static let desc: String = ("""
                        Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

                        Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

                        Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
                        """)
    
    // Tweak long descriptions
    static let descs: [String: String] = [
        "activator"     : desc,
        "cydia"         : ("""
                            This is cydia, the first jailbreak package manager. Although it has been the primary package manager for so many years, it's becoming outdated and harder to maintain. Cydia should come packaged with most jailbreaks, if not automatiacally installed.
                            """),
        "cylinder"      : desc,
        "jellyfish"     : ("""
                            Inspired by the watchOS Motion face, Jellyfish aims to make your Lock screen more modern, more beautiful, and more useful.

                            Jellyfish refreshes the Lock screen with a beautiful new design, emphasizing both the time and date. The date takes its colour from your wallpaper, creating a beautiful blended effect, while still retaining its legibility.

                            Jellyfish also adds weather to your Lock screen, so you can always view it at a quick glance. While adding this new level of information, your Lock screen retains its simplicity, avoiding a cluttered look.
                            """),
        "kalm"          : desc,
        "lockplus_pro"  : desc,
        "portrait_xi"   : desc,
        "snowboard"     : ("""
                            Snowboard is a lightweight spiritual successor to the legendary Winterboard theming engine. It works with iOS 7 and up and supports formats from all other popular theming engines.

                            Snowboard is faithful to the spirit of jailbreaking, and as an essential tool, it is therefore available for free.
                            """),
        "xen_html"      : desc,
    ]

    // To fully enjoy this section below, toggle Preferences > Text Editing > Code Folding Ribbon on and fold all tweaks.
    static let packages: [String: Tweak] = [
        "activator"     : Tweak(
        name: "Activator", dev: "Ryan Petrich", repo: "https://rpetri.ch/repo", shortDesc: "Centralized gestures, button and shortcut management for iOS.", type: "tweak", price: 0),
        "cydia"         : Tweak(
            name: "Cydia", dev: "Jay Freeman (saurik)", repo: "https://apt.binger.com/", shortDesc: "Graphical iPhone font-end for APT.", type: "application", price: 0),
        "cylinder"      : Tweak(
        name: "Cylinder", dev: "R33d", repo: "https://repo.packix.com", shortDesc: "Make your icons dance.", type: "tweak", price: 0),
        "jellyfish"     : Tweak(
        name: "Jellyfish", dev: "Dynastic", repo: "https://repo.dynastic.co", shortDesc: "Modernize your lockscreen.", type: "tweak", price: 1.99),
        "kalm"          : Tweak(
            name: "Kalm", dev: "UBIK", repo: "https://repo.chariz.com", shortDesc: "A beautiful first sight.", type: "tweak", price: 0.99),
        "lockplus_pro"  : Tweak(
        name: "Lockplus Pro", dev: "Junesiphone", repo: "https://junesiphone.com/supersecret", shortDesc: "Modernize your lockscreen.", type: "tweak", price: 5.00),
        "portrait_xi"   : Tweak(
        name: "Portrait XI", dev: "Fortfoxmobile", repo: "https://repo.packix.co", shortDesc: "Single camera portait mode.", type: "tweak", price: 4.99),
        "snowboard"     : Tweak(
        name: "SnowBoard", dev: "Spark Dev", repo: "https://sparkdev.me", shortDesc: "Snowboard theming engine.", type: "tweak", price: 0),
        "xen_html"      : Tweak(
        name: "Xen HTML", dev: "Matt Clarke", repo: "https://repo.packix.com", shortDesc: "Xen HTML allows for displaying widgets on both the iOS Lockscreen and Homescreen.", type: "tweak", price: 0),
    ]
    
    // Story builds
    static let stories: [String: [[String]]] = [
        "app_theming": [["Reasons to Jailbreak", "App Theming", "Change the way your app icons appear", "banner1.1", "true"],
                        ["p", "Unlike Android, Apple", "doesn't provide any default theming options to their devices. Although limited icon theming is possible with an unjailbroken device, many users have found out that the process is highly inefficient. With jailbreaking, users are able to unlock the full potentials of icon theming."],
                        ["i", "snowboard_banner", "Snowboard is currently the most popular theming engine. It supports iOS 7+."],
                        ["p", "", "With appropriate themeing engines such as SnowBoard, Anemone, or iThemer, users can easily change the appearance of app icons, notification badges, dock labels, and even system glyphs."],
                        ["p", "", "As more and more devices are becoming eligible to jailbreaking, develops and designers race to create the ideal themes to appeal their customers. With thousands of theming packages that alters the appearances of the majority of iOS apps, theming can allow devices to stand unique to others."]]
    ]

    // Migrate to this
    static let repos: [String: Repo] = [
        "packix": Repo("Packix", url: "https://repo.packix.com"),
        "chariz": Repo("Chariz", url: "https://chariz.com"),
        "dynastic": Repo("Dynastic", url: "https://repo.dynastic.co"),
    ]
}
