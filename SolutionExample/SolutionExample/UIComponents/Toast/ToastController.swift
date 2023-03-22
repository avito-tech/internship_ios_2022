import UIKit

final class ToastController: UIAlertController {
    
    // MARK: - Properties
    let window: UIWindow? = {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene.map(UIWindow.init(windowScene: ))
        
        window?.isUserInteractionEnabled = false
        window?.rootViewController = UIViewController()
        window?.windowLevel = .alert + 1
        window?.makeKeyAndVisible()
        
        return window
    }()
    
    // MARK: - Methods
    func show() {
        window?.rootViewController?.present(self, animated: false)
        
        Task {
            await Task.sleep(seconds: 2)
            dismiss(animated: false)
        }
    }
}
