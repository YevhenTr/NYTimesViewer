//
//  ArticleResponseModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

struct ArticlesResponseModel: Codable {
    let results: [ArticleModel]
}

struct MediaModel: Codable {
    let metadata: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case metadata = "media-metadata"
    }
    
    static func create(with url: String) -> MediaModel {
        let imageModel = ImageModel(url: url, format: "Standard Thumbnail")
        
        return MediaModel(metadata: [imageModel])
    }
}

struct ImageModel: Codable {
    let url: String
    let format: String
}
