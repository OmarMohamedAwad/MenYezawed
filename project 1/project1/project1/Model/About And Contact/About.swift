
import Foundation
import ObjectMapper

struct AboutResponse : Mappable {
	var value : Bool?
	var data : String?
	var comment : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		data <- map["data"]
		comment <- map["comment"]
	}

}
