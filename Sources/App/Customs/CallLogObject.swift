
import Vapor

// MARK: - CallLogObject
struct CallLogObject: Content {
    let data    : [CallObjectDatum]
    let pages   : Int
}

// MARK: - Datum
struct CallObjectDatum: Codable {
    let method, host, path, rawPath             : String
    let contentLength                           : Int
    let userAgent                               : String
    let responseCode                            : Int
    let apiKey, timeStamp, apiVersion, apiName  : String
    let apiid, orgID, oauthID                   : String
    let requestTime                             : Int
    let rawRequest, rawResponse, ipAddress      : String
    let geo                                     : Geo
    let tags                                    : [String]

    enum CodingKeys: String, CodingKey {
        case method             = "Method"
        case host               = "Host"
        case path               = "Path"
        case rawPath            = "RawPath"
        case contentLength      = "ContentLength"
        case userAgent          = "UserAgent"
        case responseCode       = "ResponseCode"
        case apiKey             = "APIKey"
        case timeStamp          = "TimeStamp"
        case apiVersion         = "APIVersion"
        case apiName            = "APIName"
        case apiid              = "APIID"
        case orgID              = "OrgID"
        case oauthID            = "OauthID"
        case requestTime        = "RequestTime"
        case rawRequest         = "RawRequest"
        case rawResponse        = "RawResponse"
        case ipAddress          = "IPAddress"
        case geo                = "Geo"
        case tags               = "Tags"
    }
}

// MARK: - Geo
struct Geo: Codable {
    let country     : Country
    let city        : City
    let location    : Location

    enum CodingKeys: String, CodingKey {
        case country    = "Country"
        case city       = "City"
        case location   = "Location"
    }
}

// MARK: - City
struct City: Codable {
    let geoNameID       : Int
    let names           : Names

    enum CodingKeys: String, CodingKey {
        case geoNameID  = "GeoNameID"
        case names      = "Names"
    }
}

// MARK: - Names
struct Names: Codable {
}

// MARK: - Country
struct Country: Codable {
    let isoCode: String

    enum CodingKeys: String, CodingKey {
        case isoCode = "ISOCode"
    }
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude : Int
    let timeZone            : String

    enum CodingKeys: String, CodingKey {
        case latitude       = "Latitude"
        case longitude      = "Longitude"
        case timeZone       = "TimeZone"
    }
}
