//
//  JokeCell.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/7/23.
//

import UIKit

class JokeCell: UITableViewCell {

    var categoryLabel = UILabel()
    var jokeLabel = UILabel()
    var dateLabel = UILabel()
    var vStack = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureJokeLable()
        configureDateLabel()
        configureCategoryLabel()
        setupVStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(joke: JokeData) {
        categoryLabel.text = joke.categories.first ?? "random"
        dateLabel.text = joke.created_at
        jokeLabel.text = joke.value
    }
    
    func configureJokeLable() {
        addSubview(jokeLabel)
        jokeLabel.font = .preferredFont(forTextStyle: .title1)
    }
    
    func configureDateLabel() {
        addSubview(dateLabel)
        dateLabel.font = .preferredFont(forTextStyle: .caption2)
    }
   
    func configureCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.font = .preferredFont(forTextStyle: .caption2)
            }
    
    func setupVStack() {
        addSubview(vStack)
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.alignment = .leading
        vStack.distribution = .fillProportionally
        [jokeLabel, dateLabel, categoryLabel].forEach { subview in
            vStack.addArrangedSubview(subview)
        }
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStack.leftAnchor.constraint(equalTo: leftAnchor),
            vStack.rightAnchor.constraint(equalTo: rightAnchor)])
        
    }
}
