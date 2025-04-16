import Foundation
import CoreLocation

class LocationDate {
    static let shared = LocationDate()
    
    var longitude: Double?
    var latitude: Double?
    
    private init() {}
}

//struct Conditions: Codable {
//    //    static let shared = Conditions()
//
//    let latitude: Double?
//    let longitude: Double?
//    let date: Date
//    let day: Date
////    let today: Bool?
//    let cloudCover: Int
//    let lightPollution: Int
//    let seeing: Int
//    let transparency: Int
//    let status: String
////    let incorrectAnswers: [String]
//    
//    enum CodingKeys: String, CodingKey {
//        case latitude
//        case longitude
//        case date
//        case day
////        case today
//        case cloudCover = "cloud_cover"
//        case lightPollution = "light_pollution"
//        case seeing
//        case transparency
//        case status
////        case incorrectAnswers = "incorrect_answers"
//    }

