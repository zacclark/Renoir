//
//  AppDelegate.swift
//  StyleGuide
//
//  Created by pivotal on 2/17/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit
import Renoir

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let window = UIWindow()
        window.rootViewController = CatalogViewController(elements: [
            InterfaceElement(
                title: "Go Button",
                description: "A button that goes",
                variants: [
                    InterfaceElementVariant(
                        title: "Green",
                        generator: {
                            let elaborateButton = UIButton(type: .Custom)
                            elaborateButton.setTitle("Press Me", forState: .Normal)
                            elaborateButton.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
                            elaborateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                            elaborateButton.layer.cornerRadius = 10
                            elaborateButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                            return elaborateButton
                        }
                    ),
                    InterfaceElementVariant(
                        title: "Red",
                        generator: {
                            let elaborateButton = UIButton(type: .Custom)
                            elaborateButton.setTitle("Press Me", forState: .Normal)
                            elaborateButton.backgroundColor = UIColor.redColor()
                            elaborateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                            elaborateButton.layer.cornerRadius = 10
                            elaborateButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                            return elaborateButton
                        }
                    )
                ]
            ),
            InterfaceElement(
                title: "Card",
                description: "Cards are good at showing information about a person. The are intended to show the name, title, picture, and a biography.",
                example: {
                    let card = Card()
                    card.imageArea.image = UIImage(named: "colbert")
                    card.titleLabel.text = "Mr. Stephen Colbert"
                    card.detailsLabel.text = "Quite the person"
                    card.masterTextView.text = "Colbert had originally studied to be an actor, but became interested in improvisational theatre when he met Second City director Del Close while attending Northwestern University. He first performed professionally as an understudy for Steve Carell at Second City Chicago; among his troupe mates were comedians Paul Dinello and Amy Sedaris, with whom he developed the sketch comedy series Exit 57. Colbert also wrote and performed on the short-lived Dana Carvey Show before collaborating with Sedaris and Dinello again on the cult television series Strangers with Candy. He gained considerable attention for his role on the latter as closeted gay history teacher Chuck Noblet. His work as a correspondent on Comedy Central's news-parody series The Daily Show first introduced him to a wide audience."
                    return card
                }
            )
        ])
        window.makeKeyAndVisible()
        self.window = window
        
        return true

    }

}

