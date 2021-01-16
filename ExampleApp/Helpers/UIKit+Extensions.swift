import UIKit

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        self.windows.first(where: \.isKeyWindow)
    }
}

extension UIWindow {
    var topViewController: UIViewController? {
        guard var topViewController = self.rootViewController else {
            return nil
        }

        while let viewController = topViewController.presentedViewController {
            topViewController = viewController
        }

        return topViewController
    }
}

extension UIViewController {
    static func fromStoryboard(_ id: String, storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: .main)) -> Self{
        storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
