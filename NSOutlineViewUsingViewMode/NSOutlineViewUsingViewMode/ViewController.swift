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
            print("child: \(index) ofItem: \(it)")
            return it.childAtIndex(index)!
        } else {
            print("child:ofItem: return the rootItem")
            return FileSystemItem.rootItem
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        // return (item == nil) ? YES : ([item numberOfChildren] != -1);
        if let it = item as? FileSystemItem {
            if it.numberOfChildren() > 0 {
                print("isItemExpandable: \(it): Yes")
                return true
            } else {
                print("isItemExpandable: \(it): No")
                return false
            }
        } else {
            print("isItemExpandable: rootItem: Yes")
            return true
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        // return (item == nil) ? 1 : [item numberOfChildren];
        if let it = item as? FileSystemItem {
            print("numberOfChildrenOfItem: \(it.numberOfChildren())")
            return it.numberOfChildren()
        }
        print("numberOfChildrenOfItem: We have been passed the root object so we return 1")
        return 1
    }
    
    
    // NSOutlineViewDelegate
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        
        let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as! NSTableCellView
        if let it = item as? FileSystemItem {
            if let textField = view.textField {
                textField.stringValue = it.relativePath
            }
            return view
        } else {
            if let textField = view.textField {
                textField.stringValue = "/"
            }
            
        }
        return view
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