import UIKit

@MainActor final class MainPageAssembly {
    func viewController() -> UIViewController {
        let service = MainPageServiceImpl(networkClient: NetworkClientImpl())
        let viewController = MainViewController()
        
        let loaderDisplayable = WeakDelayLoaderDisplayable(
            loaderDisplayable: viewController
        )
        
        let messageDisplayable = WeakMessageDisplayable(
            messageDisplayable: viewController
        )
        
        let contentPlaceholderDisplayable = WeakContentPlaceholderDisplayable(
            contentPlaceholderDisplayable: viewController
        )
        
        let presenter = MainPresenter(
            service: service,
            loaderDisplayable: loaderDisplayable,
            messageDisplayable: messageDisplayable,
            contentPlaceholderDisplayable: contentPlaceholderDisplayable
        )
        
        viewController.addDisposeBag(presenter)
        presenter.view = viewController
        
        return viewController
    }
}
