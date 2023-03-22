import Foundation

final class MainPresenter {
    
    // MARK: - Weak properties
    @MainActor weak var view: MainViewViewInput? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - Dependencies
    private let service: MainPageService
    private let loaderDisplayable: LoaderDisplayable
    private let messageDisplayable: MessageDisplayable
    private let contentPlaceholderDisplayable: ContentPlaceholderDisplayable
    
    // MARK: - Init
    init(
        service: MainPageService,
        loaderDisplayable: LoaderDisplayable,
        messageDisplayable: MessageDisplayable,
        contentPlaceholderDisplayable: ContentPlaceholderDisplayable
    ) {
        self.service = service
        self.loaderDisplayable = loaderDisplayable
        self.messageDisplayable = messageDisplayable
        self.contentPlaceholderDisplayable = contentPlaceholderDisplayable
    }
    
    // MARK: - SetUp
    @MainActor private func setUpView() {
        view?.onTopRefresh = { [weak self] in
            self?.proceedToLoadCompany(isRefreshing: true)
        }
        
        view?.onViewDidLoad = { [weak self] in
            self?.proceedToLoadCompany()
        }
    }

    // MARK: - Load company
    private func proceedToLoadCompany(isRefreshing: Bool = false) {
        Task {
            await proceedToLoadCompany(isRefreshing: isRefreshing)
        }
    }
    
    private func proceedToLoadCompany(isRefreshing: Bool = false) async {
        let loaderDisplayable = isRefreshing ? nil : loaderDisplayable
        
        await loaderDisplayable?.showLoader()
        let result = await service.company()
        await loaderDisplayable?.hideLoader()
        await view?.endRefreshing()
        
        switch result {
        case let .success(response):
            await handleCompanyLoading(response)
        case let .failure(error):
            await handleCompanyLoading(error, isRefreshing: isRefreshing)
        }
    }
    
    private func handleCompanyLoading(_ response: CompanyResponse) async {
        await view?.setTitle(response.name)
        await view?.display(models: response.employees
            .sorted { $0.name < $1.name }
            .enumerated()
            .map {
                TableViewModel(
                    id: "\($0)",
                    data: EmployeeCellData(
                        name: $1.name,
                        skills: $1.skills,
                        phoneNumber: $1.phoneNumber
                    ),
                    cellType: EmployeeCell.self
                )
            }
        )
    }
    
    private func handleCompanyLoading(_ error: NetworkError, isRefreshing: Bool) async {
        if isRefreshing {
            await messageDisplayable.showMessage(error: error)
            return
        }
        
        await contentPlaceholderDisplayable.showPlaceholder(error: error) { [weak self] in
            self?.proceedToLoadCompany()
        }
    }
}
