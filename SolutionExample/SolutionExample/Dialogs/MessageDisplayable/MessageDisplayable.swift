import UIKit

@MainActor protocol MessageDisplayable: AnyObject {
    func showMessage(_ message: String)
}

extension MessageDisplayable {
    func showMessage(error: NetworkError) {
        switch error {
        case .noInternetConnection, .timeout:
            showMessage("Нет интернета")
        default:
            showMessage("Неизвестная ошибка")
        }
    }
    
}

extension MessageDisplayable where Self: UIViewController {
    func showMessage(_ message: String) {
        ToastController(title: nil, message: message, preferredStyle: .actionSheet).show()
    }
}
