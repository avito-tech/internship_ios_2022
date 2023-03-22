import UIKit

final class EmployeeCell: UITableViewCell, TableViewCellInput {
    
    // MARK: - Subviews
    private let nameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let skillsLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(skillsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TableViewCellInput
    func update(with data: Any) {
        guard let data = data as? EmployeeCellData else { return }
        
        nameLabel.text = "Name: \(data.name)"
        phoneNumberLabel.text = "Phone: \(data.phoneNumber)"
        skillsLabel.text = "Skills: \(data.skills.joined(separator: ", "))"
    }
    
    // MARK: - Layout
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        Spec.layout(
            size: size,
            nameLabel: nameLabel,
            phoneNumberLabel: phoneNumberLabel,
            skillsLabel: skillsLabel
        ).preferredSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = Spec.layout(
            size: bounds.size,
            nameLabel: nameLabel,
            phoneNumberLabel: phoneNumberLabel,
            skillsLabel: skillsLabel
        )
    
        nameLabel.frame = layout.nameLabelFrame
        phoneNumberLabel.frame = layout.phoneNumberLabelFrame
        skillsLabel.frame = layout.skillsLabelFrame
    }
}

// MARK: - Spec
fileprivate enum Spec {
    
    static let contentInsets = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
    static let interItemSpacing: CGFloat = 10
    
    // MARK: - Layout
    typealias Layout = (
        nameLabelFrame: CGRect,
        phoneNumberLabelFrame: CGRect,
        skillsLabelFrame: CGRect,
        preferredSize: CGSize
    )
    
    static func layout(
        size: CGSize,
        nameLabel: UILabel,
        phoneNumberLabel: UILabel,
        skillsLabel: UILabel
    ) -> Layout {
        let contentSize = CGSize(
            width: size.width - contentInsets.left - contentInsets.right,
            height: size.height
        )
        
        let nameLabelSize = nameLabel.sizeThatFits(contentSize)
        let nameLabelFrame = CGRect(
            x: contentInsets.left,
            y: contentInsets.top,
            width: nameLabelSize.width,
            height: nameLabelSize.height
        )
        
        let phoneNumberLabelSize = phoneNumberLabel.sizeThatFits(contentSize)
        let phoneNumberLabelFrame = CGRect(
            x: contentInsets.left,
            y: nameLabelFrame.maxY + interItemSpacing,
            width: phoneNumberLabelSize.width,
            height: phoneNumberLabelSize.height
        )
        
        let skillsLabelSize = skillsLabel.sizeThatFits(contentSize)
        let skillsLabelFrame = CGRect(
            x: contentInsets.left,
            y: phoneNumberLabelFrame.maxY + interItemSpacing,
            width: skillsLabelSize.width,
            height: skillsLabelSize.height
        )
        
        let customBackgroundViewFrame = CGRect(
            x: .zero,
            y: .zero,
            width: size.width,
            height: skillsLabelFrame.maxY + contentInsets.bottom
        )
        
        let preferredSize = CGSize(
            width: size.width,
            height: skillsLabelFrame.maxY + contentInsets.bottom
        )
        
        return (
            nameLabelFrame,
            phoneNumberLabelFrame,
            skillsLabelFrame,
            preferredSize
        )
    }
}
