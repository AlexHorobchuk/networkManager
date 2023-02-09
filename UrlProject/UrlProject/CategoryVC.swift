//
//  ViewController.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/4/23.
//

import UIKit

class CategoryVC: UIViewController {

    var tableView = UITableView()
    var categories = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchCategories()
        configureTableView()
    }
    
    func fetchCategories() {
        JokeNetworkManager.shared.fetchData(fetchingtype: .categorys) { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories as! [String]
            case .failure(let error):
                let alert = UIAlertController(title: "Ooops", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(.init(title: "Ok", style: .cancel))
                self?.present(alert, animated: true)
                
            }
            
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 60
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "Category")        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)])
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = JokeDetailVC.JokeDetailVCData(category: categories[indexPath.row])
        let vc = JokeDetailVC(jokeVCData: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category") as! CategoryCell
        let category = categories[indexPath.row]
        cell.set(category: category)
        return cell
    }
    
    
}
