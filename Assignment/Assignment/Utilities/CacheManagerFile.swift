//
//  CacheManagerFile.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//

import Foundation
import UIKit

class CacheManager {
    var memoryCache = NSCache<NSURL, UIImage>()
    let fileManager = FileManager.default

    lazy var cacheDirectory: URL = {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }()
    
    func diskCacheURL(for url: URL) -> URL {
        return cacheDirectory.appendingPathComponent(url.lastPathComponent)
    }
}

