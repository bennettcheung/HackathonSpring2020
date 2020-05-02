//
//  PixaBayResponse.swift
//  Hackathon
//
//  Created by BC on 2020-04-29.
//  Copyright © 2020 BC. All rights reserved.
//

import Foundation

struct PixaBayResponse: Codable {
    var total: Int
    var totalHits: Int
    var hits: [ImageDetail]
}

struct ImageDetail: Codable, Hashable{
    var previewURL: String
    var largeImageURL: String
    var type: String
    var tags: String
}
