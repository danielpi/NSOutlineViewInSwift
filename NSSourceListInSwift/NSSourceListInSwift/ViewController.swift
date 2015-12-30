//
//  ViewController.swift
//  NSSourceListInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var sourceView: NSOutlineView!
	
    var fauna = Life(name: "Fauna")
    let flora = Life(name: "Flora")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let panthera = Genus(name: "Panthera", icon: NSImage(named: "Panthera"))
        let _ = Species(name: "Lion", icon: NSImage(named: "Lion"), genus: panthera)
        let _ = Species(name: "Tiger", icon: NSImage(named: "Tiger"), genus: panthera)
        let _ = Species(name: "Leopard", icon: NSImage(named: "Leopard"), genus: panthera)
        fauna.genus.append(panthera)
		
        let antigonia = Genus(name: "Antigonia", icon: NSImage(named:"Antigonia"))
        let _ = Species(name: "Capros", icon:nil, genus: antigonia)
        let _ = Species(name: "Eos", icon:nil, genus: antigonia)
        fauna.genus.append(antigonia)
        
        let banksia = Genus(name: "Banksia", icon: nil)
        let _ = Species(name: "Serrata", icon:nil, genus: banksia)
        flora.genus.append(banksia)
        
        sourceView.expandItem(sourceView.itemAtRow(0))
        sourceView.expandItem(sourceView.itemAtRow(3))
    }
	
}

// MARK:- Outline View Data Source

extension ViewController: NSOutlineViewDataSource {

    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
		guard let item = item else {
			switch index {
			case 0:		return fauna
			default:	return flora
			}
		}
		
		guard let displayable = item as? SourceListItemDisplayable else {
			assert(false, "outlineView:index:item: gave a dud item")
			return self
		}
		
		guard let child = displayable.childAtIndex(index) else {
			assert(false, "outlineView:index:item: gave a dud item")
			return self
		}
		
		return child
	}
	
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
		guard let displayable = item as? SourceListItemDisplayable else { return false }
		return displayable.count() > 0
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
		if item == nil { return 2 }
		guard let displayable = item as? SourceListItemDisplayable else { return 0 }
		return displayable.count()
	}
}

// MARK:- Outline View Delegate

extension ViewController: NSOutlineViewDelegate {
	
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
		
		// Ensure that the passed item is valid and can be used to create a table cell
		guard let displayable = item as? SourceListItemDisplayable,
			view = outlineView.makeViewWithIdentifier(displayable.cellID(), owner: self) as? NSTableCellView
			else { return nil }
		
		// If we have a text field, set it to the item's name
		if let textField = view.textField {
			textField.stringValue = displayable.name
		}
		
		// If we have animage view, set it to the item's icon
		if let imageView = view.imageView {
			imageView.image = displayable.icon
		}
		
		return view
    }
	
	func outlineView(outlineView: NSOutlineView, shouldSelectItem item: AnyObject) -> Bool {
		return !self.outlineView(outlineView, isGroupItem: item)
	}
	
    func outlineView(outlineView: NSOutlineView, isGroupItem item: AnyObject) -> Bool {
		return item is Life
    }
	
}

