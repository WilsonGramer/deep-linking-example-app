import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        self.handleDeepLinkIfNeeded(for: urlContexts)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        DispatchQueue.main.async {
            self.handleDeepLinkIfNeeded(for: connectionOptions.urlContexts)
        }
    }
}

// MARK: - Handle deep links

extension SceneDelegate {
    func handleDeepLinkIfNeeded(for urlContexts: Set<UIOpenURLContext>) {
        guard let context = urlContexts.first else { return }

        self.handleDeepLink(url: context.url)
    }

    /// Returns `true` if handled successfully.
    func handleDeepLink(url: URL) {
        guard
            url.scheme == "dev.gramer.exampleapp",
            let host = url.host
        else {
            return
        }

        var viewController: UIViewController
        switch host {
        case "link":
            viewController = .fromStoryboard("LinkedViewController")
        // TODO: Add additional cases for each path you want to handle
        default:
            return
        }

        guard let topViewController = UIApplication.shared.firstKeyWindow?.topViewController else {
            return
        }

        topViewController.present(viewController, animated: true)
    }
}
