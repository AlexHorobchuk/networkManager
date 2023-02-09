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
    }
    override func viewWillAppear(_ animated: Bool) {
        favoriteJokes = JokeSavingManager.shared.getAllSavedJokes()
    }
    
    func reloadTableView() {
        favoriteJokes = JokeSavingManager.shared.getAllSavedJokes()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
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
}


extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteJokes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = JokeDetailVC.JokeDetailVCData(joke: favoriteJokes[indexPath.row], action: reloadTableView)
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
    

