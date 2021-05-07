//
//  FeedItemsMapper.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/6/21.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var feed: [DefectItem] {
            return items.map { $0.item }
        }
    }

    private struct Item: Decodable {
        let id: UUID
        let creatorId: UUID
        let stationId: UUID
        let aircraftId: UUID
        let ataCodeId: UUID
        let createdDate: String
        var defectDescription: String

        var item: DefectItem {
            return DefectItem(id: id, creatorId: creatorId, stationId: stationId, aircraftId: aircraftId, ataCodeId: ataCodeId, createdDate: Date(string: createdDate), defectDescription: defectDescription)
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        
        return .success(root.feed)
    }
}
