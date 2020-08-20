//
//  ArticleModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation
import CoreData

struct ArticleModel: Codable, Equatable {
    
    // MARK: - Properties
    
    let id: Int
    let title: String
    let preview: String
    let url: String
    let media: [MediaModel]
    let publishedAt: String
    let byLine: String
    
    var imageURL: String? {
        return self.media.object(at: 0)?
            .metadata
            .first(where: { $0.format == "Standard Thumbnail" })?
            .url
    }
    
    // MARK: - CodingKey
    
    enum CodingKeys: String, CodingKey {
        case id, title, url, media
        case preview = "abstract"
        case publishedAt = "published_date"
        case byLine = "byline"
    }
    
    // MARK: - Equatable
    
    static func == (lhs: ArticleModel, rhs: ArticleModel) -> Bool {
        return lhs.url == rhs.url
    }
}

// MARK: - CoreDataStorable

extension ArticleModel: CoreDataStorable {

    typealias ManagedObject = CDArticleModel

    func coreDataModel(with context: NSManagedObjectContext) -> ManagedObject {
        let managedObject = ManagedObject(context: context)

        managedObject.id = Int64(self.id)
        managedObject.title = self.title
        managedObject.preview = self.preview
        managedObject.url = self.url
        managedObject.publishedAt = self.publishedAt
        managedObject.byLine = self.byLine
        managedObject.imageURL = self.imageURL ?? ""

        return managedObject
    }

    static func create(from managedObject: ManagedObject) -> Self? {

        return ArticleModel(id: Int(managedObject.id),
                            title: managedObject.title ?? "",
                            preview: managedObject.preview ?? "",
                            url: managedObject.url ?? "",
                            media: [MediaModel.create(with: managedObject.imageURL ?? "")],
                            publishedAt: managedObject.publishedAt ?? "",
                            byLine: managedObject.byLine ?? "")
    }
}

// MARK: - Identifiable

extension ArticleModel: Identifiable {
    var ID: Int { self.id }
}

extension CDArticleModel: Identifiable {

    var ID: Int { return Int(self.id) }
}
