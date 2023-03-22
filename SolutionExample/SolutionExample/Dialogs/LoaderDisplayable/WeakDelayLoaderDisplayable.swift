import Foundation

final class WeakDelayLoaderDisplayable: LoaderDisplayable {
    
    // MARK: - Properties
    private weak var loaderDisplayable: LoaderDisplayable?
    
    // MARK: - Init
    init(loaderDisplayable: LoaderDisplayable) {
        self.loaderDisplayable = loaderDisplayable
    }
    
    // MARK: - LoaderDisplayable
    func showLoader() {
        loaderDisplayable?.showLoader()
    }
    
    func hideLoader() {
        loaderDisplayable?.hideLoader()
    }
}
