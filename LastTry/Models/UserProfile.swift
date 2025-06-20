import Foundation

public struct UserProfile: Codable {
    public var name: String
    public var gender: String
    public var ethnicity: String
    public var fieldOfStudy: String
    public var gradeLevel: String
    public var gpa: Double?
    public var avatarType: AvatarType
    // Daily login streak properties
    public var streakCount: Int
    public var lastLoginDate: Date?
    
    public enum AvatarType: String, Codable {
        case cat
        case bear
        case bunny
        case dog
    }
    
    public init(name: String, gender: String, ethnicity: String, fieldOfStudy: String, gradeLevel: String, gpa: Double? = nil, avatarType: AvatarType, streakCount: Int = 0, lastLoginDate: Date? = nil) {
        self.name = name
        self.gender = gender
        self.ethnicity = ethnicity
        self.fieldOfStudy = fieldOfStudy
        self.gradeLevel = gradeLevel
        self.gpa = gpa
        self.avatarType = avatarType
        self.streakCount = streakCount
        self.lastLoginDate = lastLoginDate
    }
}

// Extension for UserDefaults storage
extension UserProfile {
    public static let userDefaultsKey = "userProfile"
    
    public static func save(_ profile: UserProfile) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    public static func load() -> UserProfile? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return nil
        }
        return profile
    }
} 