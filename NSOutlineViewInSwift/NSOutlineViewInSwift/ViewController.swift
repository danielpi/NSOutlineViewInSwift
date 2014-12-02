//
//  ViewController.swift
//  NSOutlineViewInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        // return (item == nil) ? [FileSystemItem rootItem] : [(FileSystemItem *)item childAtIndex:index];
        if let it = item as? FileSystemItem {
            println("child: \(index) ofItem: \(it)")
            return it.childAtIndex(index)!
        } else {
            println("child:ofItem: return the rootItem")
            return FileSystemItem.rootItem
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        // return (item == nil) ? YES : ([item numberOfChildren] != -1);
        if let it = item as? FileSystemItem {
            if it.numberOfChildren() > 0 {
                println("isItemExpandable: \(it): Yes")
                return true
            } else {
                println("isItemExpandable: \(it): No")
                return false
            }
        } else {
            println("isItemExpandable: rootItem: Yes")
            return true
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        // return (item == nil) ? 1 : [item numberOfChildren];
        if let it = item as? FileSystemItem {
            println("numberOfChildrenOfItem: \(it.numberOfChildren())")
            return it.numberOfChildren()
        }
        println("numberOfChildrenOfItem: We have been passed the root object so we return 1")
        return 1
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn: NSTableColumn?, byItem:AnyObject?) -> AnyObject? {
        // return (item == nil) ? @"/" : [item relativePath];
        if let item = byItem as? FileSystemItem {
            println("objectValueForTableColumn:byItem: \(item)")
            return item.relativePath
        }
        return nil
    }

}

/*
@implementation DataSource
// Data Source methods

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {

return (item == nil) ? 1 : [item numberOfChildren];
}


- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
return (item == nil) ? YES : ([item numberOfChildren] != -1);
}


- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {

return (item == nil) ? [FileSystemItem rootItem] : [(FileSystemItem *)item childAtIndex:index];
}


- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
return (item == nil) ? @"/" : [item relativePath];
}

@end
*/