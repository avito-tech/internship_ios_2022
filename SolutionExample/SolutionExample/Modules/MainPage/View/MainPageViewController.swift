import UIKit

final class MainViewController:
    BaseViewController,
    MainViewViewInput,
    LoaderDisplayable,
    ContentPlaceholderDisplayable
{
    // MARK: - Subviews
    private let loader = Loader()
    private let tableView = TableView()
    private let contentPlaceholder = ContentPlaceholder()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loader)
        view.addSubview(contentPlaceholder)
        view.addSubview(tableView)
    }
    
    // MARK: - MainViewViewInput
    var onTopRefresh: (() -> ())? {
        get { tableView.onTopRefresh }
        set { tableView.onTopRefresh = newValue }
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func display(models: [TableViewModel]) {
        tableView.display(models: models)
    }
    
    func endRefreshing() {
        tableView.endRefreshing()
    }
    
    // MARK: - LoaderDisplayable
    func showLoader() {
        loader.isHidden = false
        loader.start()
        view.bringSubviewToFront(loader)
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stop()
        view.sendSubviewToBack(loader)
    }
    
    // MARK: - ContentPlaceholderDisplayable
    func showPlaceholder(model: ContentPlaceholderModel) {
        contentPlaceholder.update(with: model)
        contentPlaceholder.isHidden = false
        view.bringSubviewToFront(contentPlaceholder)
    }
    
    func hidePlaceholder() {
        contentPlaceholder.isHidden = true
        view.sendSubviewToBack(contentPlaceholder)
    }
    
    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loader.frame = view.bounds
        contentPlaceholder.frame = view.bounds
        tableView.frame = view.bounds
    }
}
