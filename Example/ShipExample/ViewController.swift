import Ship
import UIKit

class ViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let dependency = RequestDependency()
        let request = GetRateLimitRequest()
        Session(dependency: dependency).send(request) { result in
            switch result {
            case .success(let rateLimit):
                print("count: \(rateLimit.count)")
                print("reset: \(rateLimit.resetDate)")

            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
