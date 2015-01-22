//
//  ViewController.swift
//  NSSourceListInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {
    
    var fauna: NSMutableArray = NSMutableArray() // Need to use NSMutableArray instead of [Genus]
    //var flora: [Genus] = [Genus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let panthera = Genus(name: "Panthera", icon: NSImage(named: "Panthera"))
        let lion = Species(name: "Lion", icon: NSImage(named: "Lion"), genus: panthera)
        let tiger = Species(name: "Tiger", icon: NSImage(named: "Tiger"), genus: panthera)
        let leopard = Species(name: "Leopard", icon: NSImage(named: "Leopard"), genus: panthera)
        fauna.addObject(panthera)
        let antigonia = Genus(name: "Antigonia", icon: NSImage(named:"Antigonia"))
        let capros = Species(name: "Capros", icon:nil, genus: antigonia)
        let eos = Species(name: "Eos", icon:nil, genus: antigonia)
        fauna.addObject(antigonia)
        
        let banksia = Genus(name: "Banksia", icon: nil)
        let serrata = Species(name: "Serrata", icon:nil, genus: banksia)
        //flora.append(banksia)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        println("child:ofItem")
        if let it: AnyObject = item {
            switch it {
            case let f as [Genus]: // This works even though NSMutableArray is more accurate
                return f[index]
            case let genus as Genus:
                return genus.species[index]
            default:
                assert(false, "outlineView:index:item: gave a dud item")
                return self
            }
        } else {
            return fauna
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        println("isItemExpandable")
        switch item {
        case let f as [Genus]:
            return true
        case let genus as Genus:
            return (genus.species.count > 0) ? true : false
        default:
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        println("numberOfChildrenOfItem")
        if let it: AnyObject = item {
            println("\(it)")
            switch it {
            case let f as NSMutableArray:
                return f.count
            case let genus as Genus:
                return genus.species.count
            default:
                return 0
            }
        } else {
            return 1
        }
    }
    
    
    // NSOutlineViewDelegate
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        println("viewForTableColumn")
        switch item {
        case let f as [Genus]:
            let view = outlineView.makeViewWithIdentifier("HeaderCell", owner: self) as NSTableCellView
            if let textField = view.textField {
                textField.stringValue = "FAUNA"
            }
            return view
        case let genus as Genus:
            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as NSTableCellView
            if let textField = view.textField {
                textField.stringValue = genus.name
            }
            if let image = genus.icon {
                view.imageView!.image = image
            }
            return view
        case let species as Species:
            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as NSTableCellView
            if let textField = view.textField {
                textField.stringValue = species.name
            }
            if let image = species.icon {
                view.imageView!.image = image
            }
            return view
        default:
            return nil
        }

    }
    
    func outlineView(outlineView: NSOutlineView, isGroupItem item: AnyObject) -> Bool {
        switch item {
        case let f as [Genus]:
            return true
        default:
            return false
        }
    }
    
}

