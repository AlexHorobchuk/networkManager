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
    }
    
    var jokeVCData: JokeDetailVCData?
    var jokeTextLabel = UILabel()
    var jokeDateLabel = UILabel()
    var jokeCategoryLabel = UILabel()
    var saveButton = UIButton()
    var vStack = UIStackView()
    
    
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
        setupVStack()
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
        jokeTextLabel.adjustsFontSizeToFitWidth = true
        jokeTextLabel.textAlignment = .center
    }
    
    func setupJokeDateLabel() {
        view.addSubview(jokeDateLabel)
        jokeDateLabel.font = .preferredFont(forTextStyle: .body)
        jokeDateLabel.numberOfLines = 2
        jokeDateLabel.adjustsFontSizeToFitWidth = true
        jokeDateLabel.textAlignment = .center
    }
    
    func setupJokeCategoryLabel() {
        view.addSubview(jokeCategoryLabel)
        jokeCategoryLabel.font = .preferredFont(forTextStyle: .body)
        jokeCategoryLabel.textAlignment = .center
        jokeCategoryLabel.adjustsFontSizeToFitWidth = true
        jokeCategoryLabel.numberOfLines = 0
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
            saveButton.heightAnchor.constraint(equalToConstant: 100),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
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
        TableViewUpdateManager.shared.updateFavoriteJokes()
    }
    func setupVStack() {
        view.addSubview(vStack)
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.alignment = .leading
        vStack.distribution = .fillProportionally
        [jokeTextLabel, jokeDateLabel, jokeCategoryLabel].forEach { subview in
            vStack.addArrangedSubview(subview)
        }
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            vStack.leftAnchor.constraint(equalTo: view.leftAnchor),
            vStack.rightAnchor.constraint(equalTo: view.rightAnchor)])
        
    }
}
