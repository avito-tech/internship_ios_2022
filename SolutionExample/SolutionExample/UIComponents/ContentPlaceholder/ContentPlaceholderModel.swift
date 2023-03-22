struct ContentPlaceholderModel {
    
    let title: String
    let button: Button
    
    struct Button {
        let title: String
        let onTap: () -> ()
    }
}
