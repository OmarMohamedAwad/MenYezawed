/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ChatDetailsResponse : Mappable {
	var value : Bool?
	var data : ChatDetailsResponseData?
	var comment : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		data <- map["data"]
		comment <- map["comment"]
	}

}

struct ChatDetailsResponseData : Mappable {
    var chat_id : Int?
    var channel_name : String?
    var total_message : Int?

    init?(map: Map) {

    }

    init(chat_id: Int, channel_name: String, total_message: Int) {
        self.chat_id = chat_id
        self.channel_name = channel_name
        self.total_message = total_message
    }
    
    mutating func mapping(map: Map) {

        chat_id <- map["chat_id"]
        channel_name <- map["channel_name"]
        total_message <- map["total_message"]
    }

}
