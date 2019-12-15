
import Foundation
import ObjectMapper

struct AllMyAccountResponse : Mappable {
    var value : Bool?
    var data : AllMyAccountResponseData?
    var comment : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["value"]
        data <- map["data"]
        comment <- map["comment"]
    }

}

struct AllMyAccountResponseData : Mappable {
    var bankAccounts : [AllMyAccountResponseBankAccounts]?
    var paginate : Paginate?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        bankAccounts <- map["bank-accounts"]
        paginate <- map["paginate"]
    }

}

struct AllMyAccountResponseBankAccounts : Mappable {
	var id : Int?
	var bank : String?
	var number : String?
	var iban : String?
	var image : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		bank <- map["bank"]
		number <- map["number"]
		iban <- map["iban"]
		image <- map["image"]
	}

}
