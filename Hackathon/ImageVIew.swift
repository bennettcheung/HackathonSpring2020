//
//  ImageVIew.swift
//  Hackathon
//
//  Created by BC on 2020-04-30.
//  Copyright © 2020 BC. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    
    init(_ url: String) {
        imageLoader = ImageLoaderCache.shared.loaderFor(path: url)
    }
    
    func imageFromData(_ data:Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    
    var body: some View {
        Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
         .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView("https://pixabay.com/get/57e8d241435ba414f6da8c7dda7936781736d7e752576c48702773d69745c45dba_1280.jpg")
    }
}
