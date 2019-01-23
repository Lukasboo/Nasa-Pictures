import Foundation
struct Result : Codable {
    let photos : [Photos]?
    
    enum CodingKeys: String, CodingKey {
        
        case photos = "photos"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
    }
    
}
