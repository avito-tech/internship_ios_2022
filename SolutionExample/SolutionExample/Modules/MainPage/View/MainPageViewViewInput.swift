@MainActor protocol MainViewViewInput: MutableViewLifecycleObserver {
    
    var onTopRefresh: (() -> ())? { get set }

    func setTitle(_ title: String)
    func display(models: [TableViewModel])
    func endRefreshing()
}
