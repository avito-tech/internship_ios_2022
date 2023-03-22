@MainActor protocol ContentPlaceholderDisplayable: AnyObject {
    func showPlaceholder(model: ContentPlaceholderModel)
    func hidePlaceholder()
}

extension ContentPlaceholderDisplayable {
    func showPlaceholder(error: NetworkError, onTap: @escaping () -> ()) {
        switch error {
        case .noInternetConnection, .timeout:
            showPlaceholder(model: .init(
                title: "Нет интернета",
                button: .init(
                    title: "Повторить",
                    onTap: { [weak self] in
                        self?.hidePlaceholder()
                        onTap()
                    }
                )
            ))
        default:
            showPlaceholder(model: .init(
                title: "Неизвестная ошибка",
                button: .init(
                    title: "Повторить",
                    onTap: { [weak self] in
                        self?.hidePlaceholder()
                        onTap()
                    }
                )
            ))
        }
    }
}
