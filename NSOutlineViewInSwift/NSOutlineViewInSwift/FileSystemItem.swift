//
//  FileSystemItem.swift
//  NSOutlineViewInSwift
//
//  Created by Daniel Pink on 2/12/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

public class FileSystemItem: NSObject {
    
    var relativePath: String
    var parent: FileSystemItem?
    
    lazy var children: [FileSystemItem]? = {
        let fileManager = NSFileManager.defaultManager()
        let fullPath = self.fullPath()
        var isDir = ObjCBool(false)
        let valid = fileManager.fileExistsAtPath(fullPath as String, isDirectory: &isDir)
        var newChildren: [FileSystemItem] = []
        
        if (valid && isDir.boolValue) {
            let array: [AnyObject]?
            do {
                array = try fileManager.contentsOfDirectoryAtPath(fullPath as String)
            } catch _ {
                array = nil
            }
            
            if let ar = array as? [String] {
                for contents in ar {
                    let newChild = FileSystemItem(path: contents, parent: self)
                    newChildren.append(newChild)
                }
            }
            return newChildren
        } else {
            return  nil
        }
    }()
    
    public override var description: String {
        return "FileSystemItem:\(relativePath)"
    }
    
    init(path: NSString, parent: FileSystemItem?) {
        self.relativePath = path.lastPathComponent.copy() as! String
        self.parent = parent
    }
    
    class var rootItem: FileSystemItem {
        get {
            return FileSystemItem(path:"/", parent: nil)
        }
    }
    
    public func numberOfChildren() -> Int {
        guard let children = self.children else { return 0 }
        return children.count
    }
    
    public func childAtIndex(n: Int) -> FileSystemItem? {
        guard let children = self.children else { return nil }
        return children[n]
    }
    
    public func fullPath() -> NSString {
        guard let parent = self.parent else { return relativePath }
        return parent.fullPath().stringByAppendingPathComponent(relativePath as String)
    }
}

/*
@interface FileSystemItem : NSObject
{
    NSString *relativePath;
    FileSystemItem *parent;
    NSMutableArray *children;
}
    
+ (FileSystemItem *)rootItem;
- (NSInteger)numberOfChildren;// Returns -1 for leaf nodes
- (FileSystemItem *)childAtIndex:(NSUInteger)n; // Invalid to call on leaf nodes
- (NSString *)fullPath;
- (NSString *)relativePath;

@end


@implementation FileSystemItem

static FileSystemItem *rootItem = nil;
static NSMutableArray *leafNode = nil;

+ (void)initialize {
    if (self == [FileSystemItem class]) {
        leafNode = [[NSMutableArray alloc] init];
    }
}
    
- (id)initWithPath:(NSString *)path parent:(FileSystemItem *)parentItem {
    self = [super init];
    if (self) {
        relativePath = [[path lastPathComponent] copy];
        parent = parentItem;
    }
    return self;
}
        
        
+ (FileSystemItem *)rootItem {
    if (rootItem == nil) {
        rootItem = [[FileSystemItem alloc] initWithPath:@"/" parent:nil];
    }
    return rootItem;
}

            
// Creates, caches, and returns the array of children
// Loads children incrementally
- (NSArray *)children {
    
    if (children == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *fullPath = [self fullPath];
        BOOL isDir, valid;
        
        valid = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        
        if (valid && isDir) {
            NSArray *array = [fileManager contentsOfDirectoryAtPath:fullPath error:NULL];
            
            NSUInteger numChildren, i;
            
            numChildren = [array count];
            children = [[NSMutableArray alloc] initWithCapacity:numChildren];
            
            for (i = 0; i < numChildren; i++)
            {
                FileSystemItem *newChild = [[FileSystemItem alloc]
                    initWithPath:[array objectAtIndex:i] parent:self];
                [children addObject:newChild];
                [newChild release];
            }
        }
        else {
            children = leafNode;
        }
    }
    return children;
}

                
- (NSString *)relativePath {
    return relativePath;
}

                    
- (NSString *)fullPath {
    // If no parent, return our own relative path
    if (parent == nil) {
        return relativePath;
    }
    
    // recurse up the hierarchy, prepending each parent’s path
    return [[parent fullPath] stringByAppendingPathComponent:relativePath];
}
    
    
- (FileSystemItem *)childAtIndex:(NSUInteger)n {
    return [[self children] objectAtIndex:n];
}
    
    
- (NSInteger)numberOfChildren {
    NSArray *tmp = [self children];
    return (tmp == leafNode) ? (-1) : [tmp count];
}
        
        
- (void)dealloc {
    if (children != leafNode) {
        [children release];
    }
    [relativePath release];
    [super dealloc];
}

@end

*/