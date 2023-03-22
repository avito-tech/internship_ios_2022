final class WeakContentPlaceholderDisplayable: ContentPlaceholderDisplayable {
    
    // MARK: - Properties
    private weak var contentPlaceholderDisplayable: ContentPlaceholderDisplayable?
    
    // MARK: - Init
    init(contentPlaceholderDisplayable: ContentPlaceholderDisplayable) {
        self.contentPlaceholderDisplayable = contentPlaceholderDisplayable
    }
    
    // MARK: - ContentPlaceholderDisplayable
    func showPlaceholder(model: ContentPlaceholderModel) {
        contentPlaceholderDisplayable?.showPlaceholder(model: model)
    }
    
    func hidePlaceholder() {
        contentPlaceholderDisplayable?.hidePlaceholder()
    }
}
