import UIKit

final class ContentPlaceholder: UIView {
    
    // MARK: - Callbacks
    private var onButtonTap: (() -> ())?
    
    // MARK: - Subviews
    private let title = UILabel()
    private let button = UIButton()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        addSubview(title)
        addSubview(button)
        
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUpContent() {
        backgroundColor = Spec.backgroundColor
        
        button.layer.cornerRadius = Spec.Button.cornerRadius
        button.backgroundColor = Spec.Button.backgroundColor
        button.setTitleColor(Spec.Button.titleColor, for: .normal)
        button.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
    }
    
    // MARK: - Update content
    func update(with model: ContentPlaceholderModel) {
        title.text = model.title
        button.setTitle(model.button.title, for: .normal)
        
        onButtonTap = {
            model.button.onTap()
        }
        
        setNeedsLayout()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleSize = title.sizeThatFits(bounds.size)
        title.frame = CGRect(
            x: (bounds.width - titleSize.width) / 2,
            y: (bounds.height - Spec.interItemSpacing) / 2 - titleSize.height,
            width: titleSize.width,
            height: titleSize.height
        )
        
        let buttonSize = button.sizeThatFits(bounds.size)
        let updatedButtonSize = CGSize(
            width: buttonSize.width
            + Spec.Button.backgroundContentInset.left
            + Spec.Button.backgroundContentInset.right,
            height: buttonSize.height
            + Spec.Button.backgroundContentInset.top
            + Spec.Button.backgroundContentInset.bottom
        )
        
        button.frame = CGRect(
            x: (bounds.width - updatedButtonSize.width) / 2,
            y: (bounds.height + Spec.interItemSpacing) / 2,
            width: updatedButtonSize.width,
            height: updatedButtonSize.height
        )
    }
    
    // MARK: - Touch handlers
    @objc private func onButtonTap(_ sender: UIButton) {
        onButtonTap?()
    }
}

// MARK: - Spec
fileprivate enum Spec {
    static let backgroundColor = UIColor.white
    static let interItemSpacing: CGFloat = 20
    
    enum Button {
        static let titleColor = UIColor.black
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        static let cornerRadius: CGFloat = 5
        static let backgroundContentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
