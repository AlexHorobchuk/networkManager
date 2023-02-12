//
//  CategoryCellTableViewCell.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/4/23.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    var categoryTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(categoryTitleLabel)
        configureCategoryTitleLable()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: String) {
        categoryTitleLabel.text = category
        
    }
    
    func configureCategoryTitleLable() {
        categoryTitleLabel.numberOfLines = 0
        categoryTitleLabel.font = .preferredFont(forTextStyle: .title1)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            categoryTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
}
