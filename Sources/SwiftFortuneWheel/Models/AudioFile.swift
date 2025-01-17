//
//  SoundFile.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/27/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

/// Auido File used for play sound in SwiftFortuneWheel
public struct AudioFile {
    
    /// Filename
    public var filename: String?
    
    /// Extension name
    public var extensionName: String?
    
    /// File's bundle
    public var bundle: Bundle?
    
    /// File's URL
    public var url: URL?
    
    /// File's identifier
    public var identifier: String?
    
    /// Initializes audio file
    /// - Parameters:
    ///   - filename: Filename
    ///   - extensionName: Extension name
    ///   - bundle: Bundle, optional
    public init(filename: String, extensionName: String, bundle: Bundle? = nil, identifier: String? = nil) {
        self.filename = filename
        self.extensionName = extensionName
        let bundle = bundle ?? Bundle.main
        self.bundle = bundle
        self.url = bundle.url(forResource: filename, withExtension: extensionName)
        self.identifier = identifier
    }
    
    /// Initializes audio file
    /// - Parameter url: File's location URL
    public init(url: URL) {
        self.url = url
    }
}
