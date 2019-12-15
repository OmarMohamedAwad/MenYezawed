
import Foundation
import ObjectMapper

struct PartenarResponse : Mappable {
    var value : Bool?
    var data : PartenarResponseData?
    var comment : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["value"]
        data <- map["data"]
        comment <- map["comment"]
    }

}


struct PartenarResponseData : Mappable {
    var auctions : [PartenarResponseAuctions]?
    var paginate : Paginate?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        auctions <- map["auctions"]
        paginate <- map["paginate"]
    }

}

struct PartenarResponseAuctions : Mappable {
	var id : Int?
	var title : String?
	var image : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		title <- map["title"]
		image <- map["image"]
	}

}
