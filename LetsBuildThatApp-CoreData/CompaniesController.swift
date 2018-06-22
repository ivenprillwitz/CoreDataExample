//
//  ViewController.swift
//  LetsBuildThatApp-CoreData
//
//  Created by Iven Prillwitz on 21.06.18.
//  Copyright © 2018 Iven Prillwitz. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {

    let cellIdentifier = "CompanieTableViewCell"

    var companies = [Company]()
    
    lazy var addButton: UIBarButtonItem = {
        let image = UIImage(named: "plus")
        let button = UIBarButtonItem(image: image,
                                     style: .plain ,
                                     target: self, action: #selector(createCompany))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationBar()
        setupTableView()
        fetchCompanies()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupNavigationBar() {
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = addButton
    }

    private func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white

        registerCellForTableView()
    }

    private func registerCellForTableView() {
        tableView.register(CompanieTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    @objc private func createCompany() {
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        let navController = CustomNavigationController(rootViewController:createCompanyController)
        present(navController, animated: true, completion: nil)
    }

    private func fetchCompanies() {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")

        do {
            self.companies = try context.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let fetchError {
            print(fetchError.localizedDescription)
        }
    }

    func didAddCompany(_ company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1 , section: 0)
        DispatchQueue.main.async {
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    func didEditCompany(_ company: Company) {
        let row = companies.index(of: company)
        if let row = row {
            let reloadIndexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [reloadIndexPath], with: .middle)
            }
        }
    }
}


extension CompaniesController {

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CompanieTableViewCell {
            cell.company = companies[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive , title: "Delete", handler: handleDeleteAction)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handleEditAction)
        editAction.backgroundColor = .black

        return [deleteAction, editAction]
    }

    private func handleDeleteAction(action: UITableViewRowAction, IndexPath: IndexPath) {
        let company = self.companies[IndexPath.row]
        self.companies.remove(at: IndexPath.row)
        self.tableView.deleteRows(at: [IndexPath], with: .automatic)

        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(company)

        do {
            try context.save()
        } catch let saveError {
            print(saveError.localizedDescription)
        }
    }

    private func handleEditAction(action: UITableViewRowAction, IndexPath: IndexPath) {
        let editCompanyController = CreateCompanyController()
        editCompanyController.company = companies[IndexPath.row]
        editCompanyController.delegate = self
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        present(navController, animated: true, completion: nil)
    }
}

