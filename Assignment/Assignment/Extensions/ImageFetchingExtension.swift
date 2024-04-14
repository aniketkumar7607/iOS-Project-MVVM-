//
//  ImageFetchingExtension.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//
import Foundation
import UIKit

extension UIImageView {
    func fetchImage(from url: URL, placeholder: UIImage? = nil, cacheManager: CacheManager? = nil, completion: ((UIImage?) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            self.image = placeholder
        }
        if let cacheManager = cacheManager, let cachedImage = cacheManager.memoryCache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion?(cachedImage)
            }
            return
        }
        if let cacheManager = cacheManager {
            let diskCacheURL = cacheManager.diskCacheURL(for: url)
            if cacheManager.fileManager.fileExists(atPath: diskCacheURL.path) {
                if let diskCachedImage = UIImage(contentsOfFile: diskCacheURL.path) {
                    cacheManager.memoryCache.setObject(diskCachedImage, forKey: url as NSURL)
                    DispatchQueue.main.async {
                        self.image = diskCachedImage
                        completion?(diskCachedImage)
                    }
                    return
                }
            }
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Failed to load image from URL: \(url). Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            guard let data = data else {
                print("No data received from URL: \(url)")
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            if let downloadedImage = UIImage(data: data) {
                
                if let cacheManager = cacheManager {
                    let diskCacheURL = cacheManager.diskCacheURL(for: url)
                    try? data.write(to: diskCacheURL)
                    
                    cacheManager.memoryCache.setObject(downloadedImage, forKey: url as NSURL)
                }
                
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                    completion?(downloadedImage)
                }
            } else {
                print("Failed to convert data to image from URL: \(url)")
                DispatchQueue.main.async {
                    completion?(nil)
                }
            }
        }.resume()
    }
}
