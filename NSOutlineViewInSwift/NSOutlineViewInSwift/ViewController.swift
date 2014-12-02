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
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return self
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return false
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        return 0
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        return nil
    }

}

