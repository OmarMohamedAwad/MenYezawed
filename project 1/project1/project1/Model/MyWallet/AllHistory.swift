

import Foundation
import ObjectMapper

struct GetAllHistoryResponse : Mappable {
    var value : Bool?
    var data : GetAllHistoryResponseData?
    var comment : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["value"]
        data <- map["data"]
        comment <- map["comment"]
    }

}

struct GetAllHistoryResponseData : Mappable {
    var transactions : [GetAllHistoryResponseTransactions]?
    var paginate : Paginate?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        transactions <- map["transactions"]
        paginate <- map["paginate"]
    }

}


struct GetAllHistoryResponseTransactions : Mappable {
	var id : Int?
	var value : Int?
	var reason : String?
	var type : String?
	var text : String?
	var created_at : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		value <- map["value"]
		reason <- map["reason"]
		type <- map["type"]
		text <- map["text"]
		created_at <- map["created_at"]
	}

}
