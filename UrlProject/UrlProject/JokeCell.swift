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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureJokeLable()
        configureDateLabel()
        configureCategoryLabel()
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
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            jokeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            jokeLabel.topAnchor.constraint(equalTo: topAnchor),
            jokeLabel.bottomAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    func configureDateLabel() {
        addSubview(dateLabel)
        dateLabel.font = .preferredFont(forTextStyle: .caption2)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            dateLabel.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.25)])
    }
   
    func configureCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.font = .preferredFont(forTextStyle: .caption2)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
            }
}
