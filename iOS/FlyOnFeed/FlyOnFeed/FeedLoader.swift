//
//  FeedLoader.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/3/21.
//

import Foundation

enum LoadFeedResult {
    case success([DefectItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

