//
//  AggregateData.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 10/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

//   let aggregate = try? newJSONDecoder().decode(Aggregate.self, from: jsonData)

import Foundation

// MARK: - Aggregate
struct Aggregate: Codable {
    let total, start, end: Int
    let refund, sales: Refund
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let type: TypeEnum
    let cardName: CardName
    let date, ok: String
    let amount, slipNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case type, cardName
        case date = "Date"
        case ok = "OK"
        case amount = "Amount"
        case slipNumber = "SlipNumber"
    }
}

enum CardName: String, Codable {
    case master = "Master"
    case visa = "VISA"
}

enum TypeEnum: String, Codable {
    case refund = "refund"
    case sales = "sales"
}

// MARK: - Refund
struct Refund: Codable {
    let total, amount: Int
}
