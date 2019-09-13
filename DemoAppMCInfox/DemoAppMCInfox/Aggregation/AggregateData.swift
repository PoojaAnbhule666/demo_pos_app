// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aggregate = try? newJSONDecoder().decode(Aggregate.self, from: jsonData)

import Foundation

// MARK: - Aggregate
struct Aggregate: Codable {
    let success: Bool
    let total, start, end: Int
    let refund, sales: Refund
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let type: TypeEnum
    let cardName: CardName
    let date, ok: String
    let amount, slipNumber, tid: Int
    let status: Status
    
    enum CodingKeys: String, CodingKey {
        case type, cardName
        case date = "Date"
        case ok = "OK"
        case amount = "Amount"
        case slipNumber = "SlipNumber"
        case tid = "Tid"
        case status = "Status"
    }
}

enum CardName: String, Codable {
    case master = "Master"
    case visa = "VISA"
}

enum Status: String, Codable {
    case failure = "Failure"
    case success = "Success"
}

enum TypeEnum: String, Codable {
    case refund = "refund"
    case sales = "sales"
}

// MARK: - Refund
struct Refund: Codable {
    let master, visa: Master
    
    enum CodingKeys: String, CodingKey {
        case master = "Master"
        case visa = "VISA"
    }
}

// MARK: - Master
struct Master: Codable {
    let total, amount: Int
}
