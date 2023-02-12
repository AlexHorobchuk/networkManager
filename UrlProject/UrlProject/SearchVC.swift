//
//  SearchVC.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/7/23.
//

import UIKit

class SearchVC: UIViewController {
    var tableView = UITableView()
    var searchField = UITextField()
    var searchData = [JokeData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchField()
        configureTableView()
    }
    
    func setupSearchField() {
        view.addSubview(searchField)
        searchField.placeholder = "Search joke"
        searchField.attributedPlaceholder = NSAttributedString(
            string: "Search joke",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        searchField.font = .preferredFont(forTextStyle: .title2)
        searchField.textAlignment = .center
        searchField.layer.borderWidth = 3
        searchField.layer.cornerRadius = 10
        searchField.layer.borderColor = UIColor.label.cgColor
        searchField.addTarget(self, action: #selector(fetchSearch), for: .editingDidEndOnExit)
        searchField.backgroundColor = .systemBackground
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            searchField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)])
        
    }
    
    @objc func fetchSearch(sender: UITextField!) {
        let searchRequest = sender.text!.filter { $0.isLetter }
        JokeNetworkManager.shared.fetchData(searchForWord: searchRequest,fetchingtype: .search) { [weak self] result in
            switch result {
            case .success(let searchResult):
                guard let searchResult = searchResult as? SearchData else {
                    print("SearchVC, fetchSearch, couldnt cast search to SearchData")
                    return
                }
                let search = searchResult.result
                if search.count != 0 {
                    self?.searchData = search
                } else {
                    let alert = UIAlertController(title: "Wrong request", message: "Didn`t find anything by your request", preferredStyle: .alert)
                    alert.addAction(.init(title: "Ok", style: .cancel))
                    self?.present(alert, animated: true)
                }
            case .failure(_):
                let alert = UIAlertController(title: "Wrong request", message: "Enter a valid word", preferredStyle: .alert)
                alert.addAction(.init(title: "Ok", style: .cancel))
                self?.present(alert, animated: true)
                
            }
            
        }
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(JokeCell.self, forCellReuseIdentifier: "Search")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)])
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
 
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = JokeDetailVC.JokeDetailVCData(joke: searchData[indexPath.row])
        let vc = JokeDetailVC(jokeVCData: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search") as! JokeCell
        let joke = searchData[indexPath.row]
        cell.set(joke: joke)
        return cell
    }
    
    
}
