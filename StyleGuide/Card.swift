import UIKit

class Card : UIView {
    let imageArea: UIView
    let titleLabel: UILabel
    let detailsLabel: UILabel
    
    let textStore: NSTextStorage
    let layoutManager: NSLayoutManager
    let textContainer1: NSTextContainer
    let textContainer2: NSTextContainer
    let textView1: UITextView
    let textView2: UITextView
    let masterLayoutManager: NSLayoutManager
    let masterTextContainer: NSTextContainer
    let masterTextView: UITextView
    
    init() {
        imageArea = UIView()
        imageArea.backgroundColor = UIColor.grayColor()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        
        detailsLabel = UILabel()
        detailsLabel.font = UIFont.italicSystemFontOfSize(12)
        
        textStore = NSTextStorage()
        layoutManager = NSLayoutManager()
        textStore.addLayoutManager(layoutManager)
        
        masterLayoutManager = NSLayoutManager()
        textStore.addLayoutManager(masterLayoutManager)
        masterTextContainer = NSTextContainer()
        masterLayoutManager.addTextContainer(masterTextContainer)
        masterTextContainer.lineFragmentPadding = 0.0
        masterTextView = UITextView(frame: CGRect.zero, textContainer: masterTextContainer)
        masterTextView.scrollEnabled = false
        masterTextView.textContainerInset = UIEdgeInsetsZero
        masterTextView.hidden = true
        masterTextView.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        masterTextView.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        masterTextView.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
        masterTextView.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        masterTextView.font = UIFont.systemFontOfSize(10)
        
        textContainer1 = NSTextContainer()
        textContainer1.lineFragmentPadding = 0.0
        layoutManager.addTextContainer(textContainer1)
        textView1 = UITextView(frame: CGRect.zero, textContainer: textContainer1)
        textView1.scrollEnabled = false
        textView1.textContainerInset = UIEdgeInsetsZero
        textView1.font = UIFont.systemFontOfSize(10)
        
        textContainer2 = NSTextContainer()
        textContainer2.lineFragmentPadding = 0.0
        layoutManager.addTextContainer(textContainer2)
        textView2 = UITextView(frame: CGRect.zero, textContainer: textContainer2)
        textView2.scrollEnabled = false
        textView2.textContainerInset = UIEdgeInsetsZero
        textView2.font = UIFont.systemFontOfSize(10)
        
        let namedViews = [
            "image" : imageArea,
            "title" : titleLabel,
            "detail" : detailsLabel,
            "leftText" : textView1,
            "rightText" : textView2,
            "master": masterTextView
        ]
        
        super.init(frame: CGRect.zero)
        
        for view in namedViews.values {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        let metrics = [
            "s":10,
            "o":2
        ]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-s-[image]-s-[title]-s-|", options: .AlignAllTop, metrics: metrics, views: namedViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image]-s-[detail]-s-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: namedViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image]-s-[leftText]-s-[rightText]-s-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: namedViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-s-[image]-(>=s)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: namedViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-s-[title]-0-[detail]-(>=s)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: namedViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[detail]-o-[leftText]-(>=s)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: namedViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[detail]-o-[rightText]-(>=s)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: namedViews))
        NSLayoutConstraint(item: imageArea, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60).active = true
        NSLayoutConstraint(item: imageArea, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60).active = true
        
        NSLayoutConstraint(item: textView1, attribute: .Height, relatedBy: .Equal, toItem: textView2, attribute: .Height, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: textView1, attribute: .Width, relatedBy: .Equal, toItem: textView2, attribute: .Width, multiplier: 1, constant: 0).active = true
        
        NSLayoutConstraint(item: masterTextView, attribute: .Width, relatedBy: .Equal, toItem: textView2, attribute: .Width, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: textView1, attribute: .Height, relatedBy: .Equal, toItem: masterTextView, attribute: .Height, multiplier: 0.5, constant: 10).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}