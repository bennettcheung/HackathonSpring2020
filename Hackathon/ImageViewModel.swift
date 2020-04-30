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
        components?.queryItems = [URLQueryItem(name: "key", value: "16299216-fca99185703295e0edae6c1cc"),
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
