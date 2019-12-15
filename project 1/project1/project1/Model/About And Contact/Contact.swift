
import Foundation
import ObjectMapper

struct ContactResponse : Mappable {
	var value : Bool?
	var data : ContactResponseData?
	var comment : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		data <- map["data"]
		comment <- map["comment"]
	}

}

struct ContactResponseData : Mappable {
    var phone : String?
    var email : String?
    var twitter : String?
    var facebook : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        phone <- map["phone"]
        email <- map["email"]
        twitter <- map["twitter"]
        facebook <- map["facebook"]
    }

}
