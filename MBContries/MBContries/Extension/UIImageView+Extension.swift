//
//  UIImageView+Extension.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 11/03/23.
//

import UIKit

// Image store to cache images for country so no need to fetch everytime.
class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

//UIImageView extension for downloading image from url
extension UIImageView {
    func url(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image: UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            } else {
                setImage(image: nil)
            }
        }
    }
}
