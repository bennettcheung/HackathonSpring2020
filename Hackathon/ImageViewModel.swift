//
//  ImageViewModel.swift
//  Hackathon
//
//  Created by BC on 2020-04-30.
//  Copyright © 2020 BC. All rights reserved.
//

import SwiftUI
import Combine

final class ImageViewModel: ObservableObject {
    static let obfuscatedKey: [UInt8] = [112, 70, 66, 125, 92, 94, 84, 81, 76, 18, 6, 47, 106, 118, 83, 82, 80, 84, 68, 114, 66, 73, 113, 0, 92, 0, 3, 0, 17, 83, 45, 98, 44, 1]

    @Published private(set) var imageDetails = [ImageDetail]()

    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        searchCancellable?.cancel()
    }

    func search(_ keyword: String) {
//        guard !imageDetails.isEmpty else {
//            return imageDetails = []
//        }
        
        var components = URLComponents(string: "https://pixabay.com/api")
        components?.queryItems = [URLQueryItem(name: "key",
                                               value:  Obfuscator().reveal(key: ImageViewModel.obfuscatedKey)),
                                  URLQueryItem(name: "q", value: keyword),
                                  URLQueryItem(name: "image_type", value: "photo"),
                                  URLQueryItem(name: "safesearch", value: "true"),
                                  URLQueryItem(name: "category", value: "travel"),
                                  URLQueryItem(name: "per_page", value: "50")]
        guard let url = components?.url else {return}

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: PixaBayResponse.self, decoder: JSONDecoder())
            .map { $0.hits }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.imageDetails, on: self)
        
    }


}
