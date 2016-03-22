import UIKit

public class CatalogViewController : UINavigationController {
    public init(elements: [InterfaceElement]) {
        let listVC = InterfaceElementsListViewController(elements: elements)
        
        super.init(rootViewController: listVC)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}