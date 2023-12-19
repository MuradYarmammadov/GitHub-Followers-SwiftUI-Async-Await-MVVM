import Foundation


struct FollowersModel: Hashable ,Decodable, Identifiable {
    let login: String
    let id: Int
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarURL = "avatar_url"
    }
}


