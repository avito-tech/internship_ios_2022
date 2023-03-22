import UIKit

final class TableView: UIView, UITableViewDataSource {
    
    // MARK: - Callbacks
    var onTopRefresh: (() -> ())?
    
    // MARK: - Data
    private var models: [TableViewModel] = []
    private var registerIds: Set<String> = []
    
    // MARK: - Subviews
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        addSubview(tableView)
        tableView.addSubview(refreshControl)
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUpContent() {
        tableView.dataSource = self
        
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.backgroundColor = Spec.backgroundColor
        
        refreshControl.addTarget(self, action: #selector(onTopRefresh(_:)), for: .valueChanged)
    }
    
    // MARK: - Methods
    func display(models: [TableViewModel]) {
        guard self.models != models else { return }
        
        self.models = models
        tableView.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < models.count else { return UITableViewCell() }
        
        let model = models[indexPath.item]
        let cell = cell(indexPath: indexPath, model: model)

        if let cell = cell as? TableViewCellInput {
            cell.update(with: model.data)
        }
        
        return cell
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
                                 
    // MARK: - Private methods
    func cell(indexPath: IndexPath, model: TableViewModel) -> UITableViewCell {
        if !registerIds.contains(model.id) {
            registerIds.insert(model.id)
            
            tableView.register(
                model.cellType,
                forCellReuseIdentifier: model.id
            )
        }
        
        return tableView.dequeueReusableCell(
            withIdentifier: model.id,
            for: indexPath
        )
    }
                                 
    @objc private func onTopRefresh(_ sender: UIRefreshControl) {
        onTopRefresh?()
    }
}

// MARK: - Spec
fileprivate enum Spec {
    static let backgroundColor = UIColor.white
}
