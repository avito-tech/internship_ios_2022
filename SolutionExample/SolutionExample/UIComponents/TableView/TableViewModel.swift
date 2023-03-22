import UIKit

typealias TableViewCell = UITableViewCell & TableViewCellInput

struct TableViewModel: Equatable {
    
    // MARK: - Properties
    let id: String
    let data: AnyHashable
    let cellType: TableViewCell.Type
    
    // MARK: - Equatable
    static func == (lhs: TableViewModel, rhs: TableViewModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.data == rhs.data
    }
}
