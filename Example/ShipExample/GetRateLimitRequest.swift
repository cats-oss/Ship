import APIKit
import Ship

struct GetRateLimitRequest: Ship.Request {
    let method = HTTPMethod.get
    let path = "/rate_limit"

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> RateLimit {
        guard let dictionary = object as? [String: AnyObject],
            let rateLimit = RateLimit(dictionary: dictionary) else {
                throw ResponseError.unexpectedObject(object)
        }

        return rateLimit
    }
}
