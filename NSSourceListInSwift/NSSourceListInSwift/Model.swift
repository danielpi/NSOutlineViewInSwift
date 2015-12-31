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
// used to create the table cell view by itself.

// This protocol is used to determine how a particular item displays. Since all
// model objects inherit from it, we do not need to perform a case-by-case setup
// of our source table cells. It also makes the model expandable - we can add
// more taxanomical rankings at any time so long as they conform to the protocol.

protocol SourceListItemDisplayable: class {
	var name: String { get }
	var icon: NSImage? { get }
	func cellID() -> String
	func count() -> Int
	func childAtIndex(index: Int) -> SourceListItemDisplayable?
}

// By making count and cellID functions, we can add default implementations to
// the protocol. Any object that implements the protocol but does not implement
// the associated method will use these defaults. This cannot be done with stored
// properties since these cannot be placed into extensions.

extension SourceListItemDisplayable {
	func cellID() -> String { return "DataCell" }
	func count() -> Int { return 0 }
	func childAtIndex(index: Int) -> SourceListItemDisplayable? { return nil }
}

// If the model objects don't subclass NSObject the program tends to crash.

class Life: NSObject, SourceListItemDisplayable {
    let name: String
    var genus: [Genus] = []
    let icon: NSImage? = nil
    
    init(name: String) {
        self.name = name
		super.init()
    }
	
	func cellID() -> String {
		return "HeaderCell"
	}	
	
	func count() -> Int {
		return genus.count
	}
	
	func childAtIndex(index: Int) -> SourceListItemDisplayable? {
		return genus[index]
	}
}

class Genus: NSObject, SourceListItemDisplayable {
    let name: String
    var species: [Species] = []
    let icon: NSImage?
    
    init(name: String, icon: NSImage?) {
        self.name = name
        self.icon = icon
		super.init()
    }
	
	func count() -> Int {
		return species.count
	}
	
	func childAtIndex(index: Int) -> SourceListItemDisplayable? {
		return species[index]
	}
}

class Species: NSObject, SourceListItemDisplayable {
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


// NOTE: I would personally remove the above model and replace it with something like this:

enum TaxonomyType {
	case Life, Domain, Kingdom, Phylum, Class, Order, Family, Genus, Species
}

class TaxonomyItem: NSObject {
	let name:	String
	let type:	TaxonomyType
	let icon:	NSImage?
	var children = [TaxonomyItem]()
	init(name: String, type: TaxonomyType, icon: NSImage?, parent: TaxonomyItem?) {
		self.name = name
		self.type = type
		self.icon = icon
		super.init()
		
		if let parent = parent {
			parent.children.append(self)
		}
	}
}