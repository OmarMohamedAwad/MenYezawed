
import Foundation
import ObjectMapper


struct AllSubCategoriesREsponse : Mappable {
    var value : Bool?
    var data : AllSubCategoriesREsponseData?
    var comment : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["value"]
        data <- map["data"]
        comment <- map["comment"]
    }

}

struct AllSubCategoriesREsponseData : Mappable {
    var categories : [AllSubCategoriesResponseSubCategories]?
    var paginate : Paginate?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        categories <- map["categories"]
        paginate <- map["paginate"]
    }

}

struct AllSubCategoriesResponseSubCategories : Mappable {
	var id : Int?
	var name : String?
	var description : String?
	var image : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		description <- map["description"]
		image <- map["image"]
	}

}
