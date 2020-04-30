//
//  ImageLoader.swift
//  Hackathon
//
//  Created by BC on 2020-04-30.
//  Copyright © 2020 BC. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class ImageLoader: ObservableObject {

    @Published var dataIsValid = false
    var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()
    }
}
class ImageLoaderCache {

    static let shared = ImageLoaderCache()

    var loaders: NSCache<NSString, ImageLoader> = NSCache()

    func loaderFor(path: String) -> ImageLoader {
        let key = NSString(string: "\(path)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let loader = ImageLoader(urlString: path)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}
