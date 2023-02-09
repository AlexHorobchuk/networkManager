//
//  JokeVC.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/4/23.
//

import UIKit

class JokeDetailVC: UIViewController {
    init (jokeVCData: JokeDetailVCData) {
        self.jokeVCData = jokeVCData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct JokeDetailVCData {
        var joke: JokeData?
        var category: String?
        var action: (() -> ())?
    }
    
    var jokeVCData: JokeDetailVCData?
    var jokeTextLabel = UILabel()
    var jokeDateLabel = UILabel()
    var jokeCategoryLabel = UILabel()
    var saveButton = UIButton()
    
    
    var joke: JokeData? {
        didSet {
            jokeTextLabel.text = joke!.value
            jokeDateLabel.text = "Created at: \(joke!.created_at)"
            jokeCategoryLabel.text = "Category: \(joke!.categories.first ?? "random")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupJokeLabel()
        setupJokeDateLabel()
        setupJokeCategoryLabel()
        setupSaveButton()
        fetchJoke()
        if jokeVCData?.joke != nil {
            checkIfSaved()
        }
    }
    
    func checkIfSaved() {
        let savedJokes = JokeSavingManager.shared.getAllSavedJokes()
        if savedJokes.contains(joke!) {
            setupSaveButtonColor(with: .systemBlue)
            saveButton.titleLabel?.text = "Delete"
        } else {
            saveButton.titleLabel?.text = "Save"
            setupSaveButtonColor(with: .systemGray)
        }
    }
    
    func fetchJoke() {
        if jokeVCData?.joke != nil {
            joke = jokeVCData?.joke
        } else {
            JokeNetworkManager.shared.fetchData(category: jokeVCData?.category ,fetchingtype: .joke) { [weak self] result in
                switch result {
                case .success(let joke):
                    let joke = joke as! JokeData
                    self?.joke = joke
                    self!.checkIfSaved()
                case .failure(let error):
                    let alert = UIAlertController(title: "Ooops", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(.init(title: "Ok", style: .cancel))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if jokeVCData?.joke == nil {
            fetchJoke()
        }
    }
    
    func setupJokeLabel() {
        view.addSubview(jokeTextLabel)
        jokeTextLabel.font = .preferredFont(forTextStyle: .title1)
        jokeTextLabel.numberOfLines = 0
        jokeTextLabel.textAlignment = .center
        jokeTextLabel.center = view.center
        jokeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokeTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jokeTextLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            jokeTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            jokeTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)])
    }
    
    func setupJokeDateLabel() {
        view.addSubview(jokeDateLabel)
        jokeDateLabel.font = .preferredFont(forTextStyle: .body)
        jokeDateLabel.textAlignment = .center
        jokeDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokeDateLabel.heightAnchor.constraint(equalToConstant: 60),
            jokeDateLabel.topAnchor.constraint(equalTo: jokeTextLabel.bottomAnchor),
            jokeDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            jokeDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)])
    }
    
    func setupJokeCategoryLabel() {
        view.addSubview(jokeCategoryLabel)
        jokeCategoryLabel.font = .preferredFont(forTextStyle: .body)
        jokeCategoryLabel.textAlignment = .center
        jokeCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokeCategoryLabel.heightAnchor.constraint(equalToConstant: 60),
            jokeCategoryLabel.topAnchor.constraint(equalTo: jokeDateLabel.bottomAnchor),
            jokeCategoryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            jokeCategoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)])
    }
    
    func setupSaveButtonColor(with color: UIColor) {
        let boldConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 85))
        let image = UIImage(systemName: "star.fill", withConfiguration: boldConfig)
        let buttonImageConfig = image?.withTintColor(color, renderingMode: .alwaysOriginal)
        saveButton.setImage(buttonImageConfig, for: .normal)
    }
    func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.titleLabel?.text = "Save"
        self.setupSaveButtonColor(with: .systemGray)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           saveButton.topAnchor.constraint(equalTo: jokeCategoryLabel.bottomAnchor),
           saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        saveButton.addTarget(self, action: #selector(saveJoke), for: .touchUpInside)
    }
    
    @objc func saveJoke(sender: UIButton!) {
        if joke != nil {
            if sender.titleLabel?.text == "Save" {
                JokeSavingManager.shared.saveJoke(joke: joke!)
                setupSaveButtonColor(with: .systemBlue)
                saveButton.titleLabel?.text = "Delete"
            } else {
                JokeSavingManager.shared.deleteJoke(joke: joke!)
                setupSaveButtonColor(with: .systemGray)
                saveButton.titleLabel?.text = "Save"
            }
        }
    }

    deinit {
        if jokeVCData?.action != nil {
            jokeVCData?.action!()
        }
    }
}
