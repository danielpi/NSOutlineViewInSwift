//
//  ViewController.swift
//  NSSourceListInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {
    
    @IBOutlet weak var sourceView: NSOutlineView!
    //var fauna: NSMutableArray = NSMutableArray() // Need to use NSMutableArray instead of [Genus]
    //var flora: [Genus] = [Genus]()
    var fauna = Life(name: "Fauna")
    let flora = Life(name: "Flora")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let panthera = Genus(name: "Panthera", icon: NSImage(named: "Panthera"))
        let lion = Species(name: "Lion", icon: NSImage(named: "Lion"), genus: panthera)
        let tiger = Species(name: "Tiger", icon: NSImage(named: "Tiger"), genus: panthera)
        let leopard = Species(name: "Leopard", icon: NSImage(named: "Leopard"), genus: panthera)
        fauna.genus.append(panthera)
        let antigonia = Genus(name: "Antigonia", icon: NSImage(named:"Antigonia"))
        let capros = Species(name: "Capros", icon:nil, genus: antigonia)
        let eos = Species(name: "Eos", icon:nil, genus: antigonia)
        fauna.genus.append(antigonia)
        
        let banksia = Genus(name: "Banksia", icon: nil)
        let serrata = Species(name: "Serrata", icon:nil, genus: banksia)
        flora.genus.append(banksia)
        
        sourceView.expandItem(sourceView.itemAtRow(0))
        sourceView.expandItem(sourceView.itemAtRow(3))
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        print("child:ofItem")
        if let it: AnyObject = item {
            switch it {
            case let l as Life: // This works even though NSMutableArray is more accurate
                return l.genus[index]
            case let genus as Genus:
                return genus.species[index]
            default:
                assert(false, "outlineView:index:item: gave a dud item")
                return self
            }
        } else {
            switch index {
            case 0:
                return fauna
            default:
                return flora
            }
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        print("isItemExpandable")
        switch item {
        case let l as Life:
            return (l.genus.count > 0) ? true : false
        case let genus as Genus:
            return (genus.species.count > 0) ? true : false
        default:
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        print("numberOfChildrenOfItem")
        if let it: AnyObject = item {
            print("\(it)")
            switch it {
            case let l as Life:
                return l.genus.count
            case let genus as Genus:
                return genus.species.count
            default:
                return 0
            }
        } else {
            return 2 // Flora and Fauna
        }
    }
    
    
    // NSOutlineViewDelegate
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        print("viewForTableColumn")
        switch item {
        case let l as Life:
            let view = outlineView.makeViewWithIdentifier("HeaderCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = l.name
            }
            return view
        case let genus as Genus:
            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = genus.name
            }
            if let image = genus.icon {
                view.imageView!.image = image
            }
            return view
        case let species as Species:
            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as! NSTableCellView
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
        case _ as Life:
            return true
        default:
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, shouldCollapseItem item: AnyObject) -> Bool {
        print("shouldCollapseItem \(item)")
        return outlineView.rowForItem(item) != 0
    }
    
    /*func outlineView(outlineView: NSOutlineView, shouldExpandItem item: AnyObject) -> Bool {
        print("shouldExpandItem \(item)")
        return true
    }*/
}

