//
//  Model.swift
//  NSSourceListInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

// It is important that every object in the model that will be
// displayed in the source list can be identified and can be 
// used to create the table cell view by itself. The Genus and
// Species class below are good examples, the fauna array in the
// ViewController is a bad example.

// If the model objects don't subclass NSObject the program tends to crash.
class Life: NSObject {
    let name: String
    var genus: [Genus] = []
    let icon: NSImage? = nil
    
    init(name: String) {
        self.name = name
    }
}
class Genus: NSObject {
    let name: String
    var species: [Species] = []
    let icon: NSImage?
    
    init(name: String, icon: NSImage?) {
        self.name = name
        self.icon = icon
    }
}

class Species: NSObject {
    let name: String
    let genus: Genus
    let icon: NSImage?
    
    init(name: String, icon: NSImage?, genus: Genus) {
        self.name = name
        self.genus = genus
        self.icon = icon
        super.init()
        genus.species.append(self)
    }
}
