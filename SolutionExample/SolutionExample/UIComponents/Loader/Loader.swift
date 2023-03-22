import UIKit

final class Loader: UIView {
    
    // MARK: - Subviews
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        addSubview(activityIndicator)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUpContent() {
        backgroundColor = Spec.backgroundColor
    }
    
    // MARK: - Methods
    func start() {
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let activityIndicatorSize = activityIndicator.sizeThatFits(bounds.size)
        activityIndicator.frame = CGRect(
            x: (bounds.width - activityIndicatorSize.width) / 2,
            y: (bounds.height - activityIndicatorSize.height) / 2,
            width: activityIndicatorSize.width,
            height: activityIndicatorSize.height
        )
    }
}

// MARK: - Spec
fileprivate enum Spec {
    static let backgroundColor = UIColor.white
}
