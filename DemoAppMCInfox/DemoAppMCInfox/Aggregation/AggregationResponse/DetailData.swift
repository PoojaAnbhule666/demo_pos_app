/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DetailData : Codable {
	let type : String?
	let amount : Int?
	let slipNumber : Int?
	let tid : String?
	let status : String?
	let approveNumber : Int?
	let autoCancelStatus : String?
	let captureSend : String?
	let transactionDate : String?
	let transactionCompletionStatus : String?
	let orgSlipNumber : String?
	let paymentDivision : String?
	let processingNumber : String?
	let cardCompanyName : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case amount = "amount"
		case slipNumber = "slipNumber"
		case tid = "tid"
		case status = "status"
		case approveNumber = "approveNumber"
		case autoCancelStatus = "autoCancelStatus"
		case captureSend = "captureSend"
		case transactionDate = "transactionDate"
		case transactionCompletionStatus = "transactionCompletionStatus"
		case orgSlipNumber = "orgSlipNumber"
		case paymentDivision = "paymentDivision"
		case processingNumber = "processingNumber"
		case cardCompanyName = "cardCompanyName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		amount = try values.decodeIfPresent(Int.self, forKey: .amount)
		slipNumber = try values.decodeIfPresent(Int.self, forKey: .slipNumber)
		tid = try values.decodeIfPresent(String.self, forKey: .tid)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		approveNumber = try values.decodeIfPresent(Int.self, forKey: .approveNumber)
		autoCancelStatus = try values.decodeIfPresent(String.self, forKey: .autoCancelStatus)
		captureSend = try values.decodeIfPresent(String.self, forKey: .captureSend)
		transactionDate = try values.decodeIfPresent(String.self, forKey: .transactionDate)
		transactionCompletionStatus = try values.decodeIfPresent(String.self, forKey: .transactionCompletionStatus)
		orgSlipNumber = try values.decodeIfPresent(String.self, forKey: .orgSlipNumber)
		paymentDivision = try values.decodeIfPresent(String.self, forKey: .paymentDivision)
		processingNumber = try values.decodeIfPresent(String.self, forKey: .processingNumber)
		cardCompanyName = try values.decodeIfPresent(String.self, forKey: .cardCompanyName)
	}

}