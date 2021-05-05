//
//  RemoteFeedLoaderTests.swift
//  FlyOnFeedTests
//
//  Created by Clay Suttner on 5/3/21.
//

import XCTest
import FlyOnFeed

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.connectivity)) {
            let clientError = NSError(domain: "test", code: 0)
            client.complete(with: clientError)
        }
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData)) {
                client.complete(withStatusCode: code, at: index)
            }
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.invalidData)) {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        }
    }
    
    func test_load_deliversNoItemsOnHTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([])) {
            let emptyListJSON = Data("{\"items\": []}".utf8)
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        
        let item1 = makeItem(
            defectId: UUID(),
            creatorId: UUID(),
            creatorEmail: "anyemail@gmail.com",
            creatorPassword: "password",
            creatorFirstName: "any",
            creatorLastName: "user",
            creatorRole: .technician,
            stationSymbol: "SFO",
            stationName: "San Francisco International",
            aircraftTailNumber: "282VA",
            aircraftManufacturer: "Airbus",
            aircraftModel: "A320",
            ataCodeValue: 2011,
            ataCodeDescription: "AIR FILTERS",
            ataChapterValue: 20,
            ataChapterDescription: "AIR CONDITIONING",
            defectCreatedDate: Date().stringValue,
            defectDescription: "Description of defect"
        )
        
        let item2 = makeItem(
            defectId: UUID(),
            creatorId: UUID(),
            creatorEmail: "anypilotemail@gmail.com",
            creatorPassword: "pilotpassword",
            creatorFirstName: "any",
            creatorLastName: "pilot",
            creatorRole: .pilot,
            stationSymbol: "SFO",
            stationName: "San Francisco International",
            aircraftTailNumber: "282VA",
            aircraftManufacturer: "Airbus",
            aircraftModel: "A320",
            ataCodeValue: 2011,
            ataCodeDescription: "AIR FILTERS",
            ataChapterValue: 20,
            ataChapterDescription: "AIR CONDITIONING",
            defectCreatedDate: Date().stringValue,
            defectDescription: "Different Description of defect"
        )
        
        let items = [item1.model, item2.model]
        
        expect(sut, toCompleteWith: .success(items)) {
            let json = makeItemsJSON([item1.json, item2.json])
            client.complete(withStatusCode: 200, data: json)
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func makeItem(
        defectId: UUID,
        creatorId: UUID,
        creatorEmail: String,
        creatorPassword: String,
        creatorFirstName: String,
        creatorLastName: String,
        creatorRole: Role,
        stationSymbol: String,
        stationName: String,
        aircraftTailNumber: String,
        aircraftManufacturer: String,
        aircraftModel: String,
        ataCodeValue: Int,
        ataCodeDescription: String,
        ataChapterValue: Int,
        ataChapterDescription: String,
        defectCreatedDate: String,
        defectDescription: String
    ) -> (model: DefectItem, json: [String: Any]) {
        
        let creator = User(id: creatorId, email: creatorEmail, password: creatorPassword, firstName: creatorFirstName, lastName: creatorLastName, role: creatorRole)
        
        let station = Station(symbol: stationSymbol, name: stationName)
        
        let aircraft = Aircraft(tailNumber: aircraftTailNumber, manufacturer: aircraftManufacturer, model: aircraftModel)
        
        let ataChapter = ATAChapter(value: ataChapterValue, description: ataChapterDescription)
        
        let ataCode = ATACode(value: ataCodeValue, description: ataCodeDescription, chapter: ataChapter)
        
        let item = DefectItem(id: defectId, creator: creator, station: station, aircraft: aircraft, ataCode: ataCode, createdDate: defectCreatedDate, defectDescription: defectDescription)
        
        let json: [String: Any] = [
            "id": defectId.uuidString,
            "creator": [
                "id": creatorId.uuidString,
                "email": creatorEmail,
                "password": creatorPassword,
                "firstName": creatorFirstName,
                "lastName": creatorLastName,
                "role": creatorRole.rawValue
            ],
            "station": [
                "symbol": stationSymbol,
                "name": stationName
            ],
            "aircraft": [
                "tailNumber": aircraftTailNumber,
                "manufacturer": aircraftManufacturer,
                "model": aircraftModel
            ],
            "ataCode": [
                "value": ataCodeValue,
                "description": ataCodeDescription,
                "chapter": [
                    "value": ataChapterValue,
                    "description": ataChapterDescription
                ]
            ],
            "createdDate": defectCreatedDate,
            "defectDescription": defectDescription
        ]
        
        return (item, json)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func expect(_ sut: RemoteFeedLoader, toCompleteWith result: RemoteFeedLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        var capturedResults = [RemoteFeedLoader.Result]()
        sut.load() { capturedResults.append($0) }
        
        action()
        
        XCTAssertEqual(capturedResults, [result], file: file, line: line)
    }
    
    class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            
            messages[index].completion(.success(data, response))
        }
    }
}
