import UIKit

class Guide : UIView {
    private let label: UILabel

    private let leftHalf: UIView
    private let leftT: UIView

    private let rightHalf: UIView
    private let rightT: UIView
    
    var text: String {
        get { return label.text ?? "" }
        set { label.text = newValue }
    }
    
    var color: UIColor {
        didSet {
            label.textColor = color
            leftHalf.backgroundColor = color
            leftT.backgroundColor = color
            rightHalf.backgroundColor = color
            rightT.backgroundColor = color
        }
    }
    
    override var bounds: CGRect {
        didSet {
            let width = bounds.size.width
            let formatted = Int(floor(width))
            
            text = "\(formatted)px"
        }
    }
    
    init() {
        label = UILabel()

        leftHalf = UIView()
        leftHalf.backgroundColor = UIColor.blackColor()
        leftT = UIView()
        leftT.backgroundColor = UIColor.blackColor()
        
        rightHalf = UIView()
        rightHalf.backgroundColor = UIColor.blackColor()
        rightT = UIView()
        rightT.backgroundColor = UIColor.blackColor()
        
        color = UIColor.blackColor()
        
        super.init(frame: CGRect.zero)
        
        let subviews = [
            "leftHalf": leftHalf,
            "leftT": leftT,
            "rightHalf": rightHalf,
            "rightT": rightT,
            "label": label,
        ]
        for s in subviews.values {
            s.translatesAutoresizingMaskIntoConstraints = false
            addSubview(s)
        }
        
        let metrics: [String:CGFloat] = [
            "op":2,
            "ip":5,
        ]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-op-[leftT]-0-[leftHalf]-ip-[label]-ip-[rightHalf(==leftHalf)]-0-[rightT]-op-|", options: .AlignAllCenterY, metrics: metrics, views: subviews))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: subviews))
        for v in [leftHalf, rightHalf] {
            NSLayoutConstraint(item: v, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 1.0 / UIScreen.mainScreen().scale).active = true
        }
        for t in [leftT, rightT] {
            NSLayoutConstraint(item: t, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 1.0 / UIScreen.mainScreen().scale).active = true
            NSLayoutConstraint(item: t, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 7).active = true
        }
        
        text = "0px"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}