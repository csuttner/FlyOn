//
//  FeedLoader.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/3/21.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([DefectItem])
    case failure(Error)
}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}

