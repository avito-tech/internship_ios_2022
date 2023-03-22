import UIKit

class BaseViewController:
    UIViewController,
    MessageDisplayable,
    MutableViewLifecycleObserver
{
    // MARK: - Data
    private var disposeBag: Any?
    
    // MARK: - MutableViewLifecycleObserver
    var onViewDidLoad: (() -> ())?
 
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?()
    }
    
    // MARK: - Methods
    func addDisposeBag(_ disposeBag: Any) {
        self.disposeBag = disposeBag
    }
}
