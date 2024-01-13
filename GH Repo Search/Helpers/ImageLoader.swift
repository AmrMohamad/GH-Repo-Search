//
//  ImageViewExtensions.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import UIKit

/// A utility for loading images and caching them.
class ImageLoader {
    /// Shared instance of the `ImageLoader` class.
    static let shared = ImageLoader()
    /// Cache to store downloaded images.
    private let imagesCache = NSCache<NSString, UIImage>()

    /// Private initializer to prevent creating multiple instances.
    private init() {}

    
    /// Loads an image from the given URL into the provided `UIImageView`.
    ///
    /// - Parameters:
    ///   - urlString: The URL of the image to be loaded.
    ///   - imageView: The `UIImageView` into which the image will be loaded.
    ///   - getSizeOfImage: A closure to provide the loaded image for further processing.
    func loadImage(withURL urlString: String, into imageView: UIImageView, imageSize getSizeOfImage: ((UIImage?) -> Void)? = nil) {
        // Clear the image view to handle cell reuse in table views.
        imageView.image = nil

        if let cachedImage = imagesCache.object(forKey: NSString(string: urlString)) {
            // If the image is already in the cache, use it and notify the caller.
            imageView.image = cachedImage
            getSizeOfImage?(cachedImage)
        } else {
            // If the image is not in the cache, download it from the URL.
            URLSession.shared.dataTask(with: URL(string: urlString)!) { [weak self] data, _, _ in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                // Cache the downloaded image.
                self?.imagesCache.setObject(image, forKey: NSString(string: urlString))

                DispatchQueue.main.async {
                    // Set the image in the image view and notify the caller with the loaded image.
                    imageView.image = image
                    getSizeOfImage?(image)
                }
            }.resume()
        }
    }
}
