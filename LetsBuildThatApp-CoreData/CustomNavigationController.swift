//
//  CustomNavigationController.swift
//  LetsBuildThatApp-CoreData
//
//  Created by Iven Prillwitz on 21.06.18.
//  Copyright © 2018 Iven Prillwitz. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupView()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func setupView() {

        navigationBar.prefersLargeTitles = true
        navigationBar.backgroundColor = .lightRed
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .lightRed
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
