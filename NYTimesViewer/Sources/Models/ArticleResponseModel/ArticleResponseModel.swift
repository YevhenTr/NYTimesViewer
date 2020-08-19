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

struct ArticleModel: Codable {
    let title: String
    let preview: String
    let url: String
    let media: [MediaModel]
    
    var imageURL: String? {
        return self.media.object(at: 0)?
            .metadata
            .first(where: { $0.format == "Standard Thumbnail" })?
            .url
    }
    
    enum CodingKeys: String, CodingKey {
        case title, url, media
        case preview = "abstract"
    }
}

struct MediaModel: Codable {
    let metadata: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case metadata = "media-metadata"
    }
}

struct ImageModel: Codable {
    let url: String
    let format: String
}
