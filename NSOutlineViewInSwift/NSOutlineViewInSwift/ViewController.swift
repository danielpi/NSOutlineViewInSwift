//
//  ViewController.swift
//  NSOutlineViewInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var outlineView: NSOutlineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outlineView.headerView = nil
    }

}


// MARK:- Outline View Data Source

extension ViewController: NSOutlineViewDataSource {
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        // return (item == nil) ? [FileSystemItem rootItem] : [(FileSystemItem *)item childAtIndex:index];
        
        guard let fileSystemItem = item as? FileSystemItem else {
            print("child:ofItem: return the rootItem")
            return FileSystemItem.rootItem
        }
        
        print("child: \(index) ofItem: \(fileSystemItem)")
        return fileSystemItem.childAtIndex(index)!
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        // return (item == nil) ? YES : ([item numberOfChildren] != -1);
        
        guard let fileSystemItem = item as? FileSystemItem else {
            // This is the root item which is always expandable
            return true
        }
        
        return fileSystemItem.numberOfChildren() > 0
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        // return (item == nil) ? 1 : [item numberOfChildren];
        
        guard let fileSystemItem = item as? FileSystemItem else {
            print("numberOfChildrenOfItem: We have been passed the root object so we return 1")
            return 1
        }
        
        print("numberOfChildrenOfItem: \(fileSystemItem.numberOfChildren())")
        return fileSystemItem.numberOfChildren()
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn: NSTableColumn?, byItem:AnyObject?) -> AnyObject? {
        // return (item == nil) ? @"/" : [item relativePath];
        
        guard let fileSystemItem = byItem as? FileSystemItem else {
            return nil
        }
        
        print("objectValueForTableColumn:byItem: \(fileSystemItem)")
        return fileSystemItem.relativePath
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