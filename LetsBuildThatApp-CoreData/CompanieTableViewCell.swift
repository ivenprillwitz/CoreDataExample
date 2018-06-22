//
//  CompanieTableViewCell.swift
//  LetsBuildThatApp-CoreData
//
//  Created by Iven Prillwitz on 21.06.18.
//  Copyright © 2018 Iven Prillwitz. All rights reserved.
//

import UIKit

class CompanieTableViewCell: UITableViewCell {

    var company: Company? {
        didSet {
            if let companyName = company?.name {
                DispatchQueue.main.async {
                    self.textLabel?.text = companyName
                }
            }
        }
    }

    let companieImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let companieLabel : UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    private func setupView() {
        backgroundColor = .teal
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        imageView?.image = UIImage(named: "select_photo_empty")
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
