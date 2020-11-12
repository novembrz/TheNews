//
//  NewsView.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import UIKit

class NewsView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "avenir", size: 24)

        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "avenir", size: 14)
        label.textColor = .darkGray

        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "avenir", size: 20)

        return label
    }()
    
    let descTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "avenir", size: 20)
        textView.isEditable = false
        textView.isSelectable = false

        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        self.backgroundColor = .white
    }
    
    
    private func configureViewComponents(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(descTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            descTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            descTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            descTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            descTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
}
