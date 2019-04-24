import Foundation

struct RateLimit {
    let count: Int
    let resetDate: Date

    init?(dictionary: [String: AnyObject]) {
        guard let count = dictionary["rate"]?["limit"] as? Int else {
            return nil
        }

        guard let resetDateString = dictionary["rate"]?["reset"] as? TimeInterval else {
            return nil
        }

        self.count = count
        self.resetDate = Date(timeIntervalSince1970: resetDateString)
    }
}
