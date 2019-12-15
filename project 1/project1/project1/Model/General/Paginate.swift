

import Foundation
import ObjectMapper

struct Paginate : Mappable {
	var total : Int?
	var count : Int?
	var per_page : Int?
	var next_page_url : String?
	var prev_page_url : String?
	var current_page : Int?
	var total_pages : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		total <- map["total"]
		count <- map["count"]
		per_page <- map["per_page"]
		next_page_url <- map["next_page_url"]
		prev_page_url <- map["prev_page_url"]
		current_page <- map["current_page"]
		total_pages <- map["total_pages"]
	}

}
