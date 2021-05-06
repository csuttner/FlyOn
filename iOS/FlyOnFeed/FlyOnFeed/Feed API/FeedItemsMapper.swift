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
    
    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [DefectItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map { $0.item }
    }
}
