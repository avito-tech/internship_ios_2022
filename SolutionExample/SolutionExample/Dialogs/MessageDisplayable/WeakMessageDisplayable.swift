final class WeakMessageDisplayable: MessageDisplayable {
    
    // MARK: - Properties
    private weak var messageDisplayable: MessageDisplayable?
    
    // MARK: - Init
    init(messageDisplayable: MessageDisplayable) {
        self.messageDisplayable = messageDisplayable
    }
    
    // MARK: - MessageDisplayable
    func showMessage(_ message: String) {
        messageDisplayable?.showMessage(message)
    }
}
