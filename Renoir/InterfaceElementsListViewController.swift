import UIKit

class InterfaceElementsListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    let elements: [InterfaceElement]
    
    init(elements: [InterfaceElement]) {
        self.elements = elements
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Catalog"
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let tableView = self.view.subviews[0] as! UITableView
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: animated)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return elements.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return elements[section].title
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return elements[section].description
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let element = elements[indexPath.section]
        
        let reuseIdentifier = "\(element.title)-cell"
        let maybeCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        let cell = maybeCell ?? UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        cell.accessoryType = .DisclosureIndicator
        for s in cell.contentView.subviews { s.removeFromSuperview() }

        let view = element.principleVariant.generator()
        view.userInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(view)
        cell.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=0)-[element]-(>=0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["element":view]))
        cell.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=0)-[element]-(>=0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["element":view]))
        NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: cell.contentView, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: cell.contentView, attribute: .CenterY, multiplier: 1, constant: 0).active = true
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let element = elements[indexPath.section]
        let vc = InterfaceElementDetailViewController(element: element)
        self.showViewController(vc, sender: self)
    }
}