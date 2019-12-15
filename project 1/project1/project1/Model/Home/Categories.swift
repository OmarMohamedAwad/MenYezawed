import Foundation
import ObjectMapper

struct AllCategoriesResponse : Mappable {
    var value : Bool?
    var data : AllCategoriesData?
    var comment : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["value"]
        data <- map["data"]
        comment <- map["comment"]
    }

}

struct AllCategoriesData : Mappable {
    var categories : [AllCategoriesCategories]?
    var paginate : Paginate?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        categories <- map["categories"]
        paginate <- map["paginate"]
    }
    
}

struct AllCategoriesCategories : Mappable {
    var id : Int?
    var name : String?
    var image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
    }

}
