public struct InterfaceElementVariant {
    let title: String
    let generator: Void -> UIView
}

public struct InterfaceElement {
    let title: String
    let description: String
    let variants : [InterfaceElementVariant]
    
    public init
    ( title       : String
    , description : String
    , example     : Void -> UIView
    ) {
        self.init(
            title: title,
            description: description,
            variants: [ InterfaceElementVariant(title: "Common", generator: example)
                      ]
        )
    }
    
    public init
    ( title       : String
    , description : String
    , variants    : [InterfaceElementVariant]
    ) {
        precondition(variants.count > 0, "ಠ_ಠ An element with no variants makes no sense to include in a catalog...")
    
        self.title       = title
        self.description = description
        self.variants    = variants
    }
    
    var principleVariant : InterfaceElementVariant {
        return variants[0]
    }
}