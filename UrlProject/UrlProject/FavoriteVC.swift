//
//  FavoriteVC.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/7/23.
//

import UIKit

class FavoriteVC: UIViewController {
    var favoriteJokes = JokeSavingManager.shared.getAllSavedJokes() {
        didSet {
            tableView.reloadData()
        }
    }
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        createObserver()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(JokeCell.self, forCellReuseIdentifier: "Joke")
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
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .updateSavedJokes, object: nil)
    }
    
    @objc func reloadTableView(_ notification: NSNotification) {
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteJokes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = JokeDetailVC.JokeDetailVCData(joke: favoriteJokes[indexPath.row])
        let vc = JokeDetailVC(jokeVCData: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Joke") as! JokeCell
        let joke = favoriteJokes[indexPath.row]
        cell.set(joke: joke)
        return cell
    }
    
    
}
    

