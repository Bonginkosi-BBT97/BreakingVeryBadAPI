//
//  UIImageView.swift
//  BreakingBad
//
//  Created by Nkosi on 2022/06/24.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
               DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
               }
            }
        }
    }
}
