//
//  CreateCompanyController.swift
//  LetsBuildThatApp-CoreData
//
//  Created by Iven Prillwitz on 21.06.18.
//  Copyright © 2018 Iven Prillwitz. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(_ company: Company)
    func didEditCompany(_ company: Company)
}


class CreateCompanyController: UIViewController {

    var delegate: CreateCompanyControllerDelegate?
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
        }
    }

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightBlue
        return view
    }()

    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter Name"
        return textfield
    }()

    let imageView: UIImageView = {
        let image = UIImage(named: "select_photo_empty")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()

    let chooseImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        button.setTitle("Choose Image", for: .normal)
        return button
    }()

    lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        button.tintColor = .white
        return button
    }()

    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        button.tintColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : company?.name
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    @objc func handleSave() {
        company == nil ? createCompany() : editCompany()
    }

    private func editCompany() {
        print("start edit company")

        let context = CoreDataManager.shared.persistentContainer.viewContext

        company?.name = nameTextField.text

        do {
            try context.save()

            if let company = company {
                dismiss(animated: true) {
                    self.delegate?.didEditCompany(company)
                }
            }
        } catch let saveError {
            print(saveError.localizedDescription)
        }
    }

    private func createCompany() {

        print("start create compnay")
        guard let companyName = nameTextField.text else { return }

        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(companyName, forKey: "name")

        do {
            try context.save()
        } catch let saveError {
            print(saveError.localizedDescription)
        }

        if let company = company as? Company {
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company)
            }
        }
    }

    private func setupView() {
        view.backgroundColor = .darkBlue
        view.addSubview(backgroundView)

        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(nameTextField)

        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        backgroundView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 12).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -12).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupNavigationBar() {
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func chooseImage() {


    }
}
