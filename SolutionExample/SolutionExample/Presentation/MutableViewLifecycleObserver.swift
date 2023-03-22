@MainActor protocol MutableViewLifecycleObserver: AnyObject {
    var onViewDidLoad: (() -> ())? { get set }
}
