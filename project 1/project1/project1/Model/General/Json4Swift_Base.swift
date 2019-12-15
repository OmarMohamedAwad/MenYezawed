

import Foundation
import ObjectMapper

struct main : Mappable {
	var value : Bool?
	var data : Data?
	var comment : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		data <- map["data"]
		comment <- map["comment"]
	}

}
