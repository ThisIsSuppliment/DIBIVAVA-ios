//
//  ImageCacheManager.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/27.
//

import Foundation

final class ImageCacheManager {
    private let cacheStorage = NSCache<NSString, NSData>()
    
    func save(_ data: Data?, forKey key: String) {
        guard let data = data else {
            return
        }
        let imageData = NSData(data: data)
        cacheStorage.setObject(imageData, forKey: key as NSString)
    }
    
    func load(forKey key: String) -> Data? {
        guard let cachedValue = cacheStorage.object(forKey: key as NSString) else {
            return nil
        }
        return Data(referencing: cachedValue)
    }
}
