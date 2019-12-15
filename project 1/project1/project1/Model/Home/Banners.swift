

import Foundation
import ObjectMapper

struct BannersResponse : Mappable {
	var value : Bool?
	var data : [BannersResponseData]?
	var comment : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		data <- map["data"]
		comment <- map["comment"]
	}

}

struct BannersResponseData : Mappable {
    var id : Int?
    var image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        image <- map["image"]
    }

}
