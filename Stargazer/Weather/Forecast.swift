import UIKit

struct WeatherResponse: Decodable {
    let product: String
    let initTime: String
    let dataseries: [DataPoint]
    
    enum CodingKeys: String, CodingKey {
        case product
        case initTime = "init"
        case dataseries
    }
}

struct DataPoint: Decodable {
    let timepoint: Int
    let cloudcover: Int
    let seeing: Int
    let transparency: Int
    let liftedIndex: Int
    let rh2m: Int
    let wind10m: Wind
    let temp2m: Int
    let precType: String

    enum CodingKeys: String, CodingKey {
        case timepoint, cloudcover, seeing, transparency
        case liftedIndex = "lifted_index"
        case rh2m, wind10m, temp2m
        case precType = "prec_type"
    }
}

struct Wind: Decodable {
    let direction: String
    let speed: Int
}
