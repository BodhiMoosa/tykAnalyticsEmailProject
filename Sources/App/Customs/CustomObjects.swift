
import Vapor

struct ResponseCodeObject : Content {
    let responseCode: Int
    var count       : Int
    var dateArray   : [String]
}

struct KeyWithResponseCodeObject : Content {
    let apiKey      : String
    var responseCode: [ResponseCodeObject]
}
