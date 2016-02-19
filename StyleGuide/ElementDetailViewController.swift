import UIKit

class ElementDetailViewController: UIViewController {
    
    let element: UILibraryElement
    let elementView: UIView
    let slider: UISlider
    var widthConstraint: NSLayoutConstraint?
    var borderLeftConstraint: NSLayoutConstraint?
    
    let leftBorder: UIView
    let rightBorder: UIView
    let tempBorder: UIView
    
    let fullGuide: Guide
    let innerGuide: Guide
    
    init(element: UILibraryElement) {
        self.element = element
        
        slider = UISlider()
        elementView = element.example()
        
        leftBorder = UIView()
        rightBorder = UIView()
        tempBorder = UIView()
        
        fullGuide = Guide()
        innerGuide = Guide()
        
        super.init(nibName: nil, bundle: nil)
        self.title = element.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.addTarget(self, action: "sliderUpdated:", forControlEvents: .ValueChanged)
        slider.addTarget(self, action: "sliderTouchEnd:", forControlEvents: .TouchUpInside)
        slider.addTarget(self, action: "sliderTouchEnd:", forControlEvents: .TouchUpOutside)
        
        let subviews = [
            "slider": slider,
            "e": elementView,
            "lb": leftBorder,
            "rb": rightBorder,
            "tb": tempBorder,
            "fg": fullGuide,
            "ig": innerGuide,
        ]
        for s in subviews.values {
            s.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(s)
        }

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[fg]-5-[ig]-10-[slider]-10-[e]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subviews))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[slider]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subviews))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lb]-0-[fg]-6-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subviews))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lb]-0-[ig]-0-[rb]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subviews))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[e]-(>=0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subviews))
        
        for border in [leftBorder, rightBorder, tempBorder] {
            border.backgroundColor = UIColor.blackColor()
            NSLayoutConstraint(item: border, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 1.0 / UIScreen.mainScreen().scale).active = true
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[b]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["b":border]))
        }
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lb]-0-[e]-0-[rb]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subviews))
        tempBorder.backgroundColor = UIColor.grayColor()
        borderLeftConstraint = NSLayoutConstraint(item: tempBorder, attribute: .Leading, relatedBy: .Equal, toItem: elementView, attribute: .Leading, multiplier: 1, constant: 0)
        borderLeftConstraint?.active = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if slider.maximumValue != Float(slider.bounds.size.width) {
            slider.minimumValue = Float(slider.currentThumbImage?.size.width ?? 31)
            slider.maximumValue = Float(slider.bounds.size.width)
            slider.value = slider.maximumValue
        }
        
        if self.widthConstraint == nil {
            let widthConstraint = NSLayoutConstraint(item: elementView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: CGFloat(slider.value))
            self.widthConstraint = widthConstraint
            widthConstraint.active = true
        }
    }
    
    func sliderUpdated(sender: UISlider) {
        if let bc = borderLeftConstraint {
            bc.constant = CGFloat(sender.value)
            
        }
    }
    
    func sliderTouchEnd(sender: UISlider) {
        if let wc = widthConstraint, bc = borderLeftConstraint {
            let v = CGFloat(sender.value)
            wc.constant = v
            bc.constant = v
        }
    }
    
}
