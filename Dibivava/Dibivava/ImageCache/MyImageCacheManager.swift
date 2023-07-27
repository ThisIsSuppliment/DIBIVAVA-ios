//
//  MyImageCacheManager.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/27.
//

import UIKit

final class MyImageCacheManager {
    static let shared: MyImageCacheManager = MyImageCacheManager()
    
    private let imageCacheManager = ImageCacheManager()
    
    private init() {}
    
    func retrieveImage(forKey imageURLString: String) -> UIImage? {
        guard let cachedImageData = imageCacheManager.load(forKey: imageURLString) else {
            return nil
        }
        
        return UIImage(data: cachedImageData)
    }
    
    func setImage(with id: String, image: UIImage) {
        guard let imageData = image.pngData() else {
            return
        }
        
        imageCacheManager.save(imageData, forKey: id)
    }
}
