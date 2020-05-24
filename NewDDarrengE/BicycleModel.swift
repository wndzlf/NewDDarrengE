//
//  BicycleModel.swift
//  NewDDarrengE
//
//  Created by admin on 2020/05/25.
//  Copyright © 2020 wndzlf. All rights reserved.
//

import Foundation

// MARK: - Empty
struct Bicycle: Codable {
    let rentBikeStatus: RentBikeStatus?
}

// MARK: - RentBikeStatus
struct RentBikeStatus: Codable {
    let listTotalCount: Int?
    let result: Result?
    let row: [BicycleInfo]?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
        case row
    }
}

// MARK: - Result
struct Result: Codable {
    let code, message: String?

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct BicycleInfo: Codable {
    let rackTotCnt, stationName, parkingBikeTotCnt, shared: String?
    let stationLatitude, stationLongitude, stationID: String?

    enum CodingKeys: String, CodingKey {
        case rackTotCnt, stationName, parkingBikeTotCnt, shared, stationLatitude, stationLongitude
        case stationID = "stationId"
    }
}
