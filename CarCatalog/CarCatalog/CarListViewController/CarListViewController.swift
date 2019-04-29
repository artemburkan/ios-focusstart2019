//
//  ViewController.swift
//  CarCatalog
//
//  Created by Artyom Burkan on 27/04/2019.
//  Copyright © 2019 Artyom Burkan. All rights reserved.
//

import UIKit
import SnapKit


class CarListViewController: UIViewController {
    private let tableView = UITableView()
    private let storage = CarStorage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation
        self.title = "Каталог автомобилей"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(createCar))
        
        // Table
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        // tableView.backgroundColor = UIColor.red
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func createCar() {
        let createCarViewController = CreateCarViewController(action: .create)
        let navigationController = UINavigationController(rootViewController: createCarViewController)

        createCarViewController.delegate = self

        present(
            navigationController,
            animated: true,
            completion: nil
        )
    }
    
}

extension CarListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let car = storage.carList[indexPath.row]
        tableCell.textLabel?.text = "Модель: \(car.model), год: \(car.releaseYear)"

        return tableCell
    }
}

extension CarListViewController: CreateCarDelegate {
    func onCreate(car: Car) {
        storage.add(car: car)
        tableView.reloadData()
    }
    
    func onEdit(car: Car, index: Int) {
        storage.edit(car: car, index: index)
        tableView.reloadData()
    }
}

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить" , handler: { [weak self]
            (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            self?.storage.remove(index: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        })
        
        let editAction = UITableViewRowAction(style: .normal, title: "Редактировать" , handler: { [weak self]
            (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            
            guard let car = self?.storage.carList[indexPath.row] else {
                return
            }
            
            let createCarViewController = CreateCarViewController(action: .edit(car: car, index: indexPath.row))
            let navigationController = UINavigationController(rootViewController: createCarViewController)
            
            createCarViewController.delegate = self
            
            self?.present(
                navigationController,
                animated: true,
                completion: nil
            )
        })
        
        return [deleteAction, editAction]
    }
}
