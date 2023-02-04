//
//  ContentCell.swift
//  RSS Reader
//
//  Created by Aliaksandr Miatnikau on 1.02.23.
//

import UIKit
import SDWebImage

final class ContentsCell: UITableViewCell {
    
    // MARK: Properties
    
    private var image = UIImageView()
    private var nameNewsTitle = UILabel()
    private var dateNewsTitle = UILabel()
    private let constraint: CGFloat = 8
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setTitlesConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setTitlesConstraints() {
        contentView.addSubview(nameNewsTitle)
        contentView.addSubview(dateNewsTitle)
        contentView.addSubview(image)
        nameNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        dateNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        nameNewsTitle.textAlignment = .left
        nameNewsTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        nameNewsTitle.numberOfLines = 4
        nameNewsTitle.adjustsFontSizeToFitWidth = true
        nameNewsTitle.lineBreakMode = .byClipping
        dateNewsTitle.font = UIFont.systemFont(ofSize: 12, weight: .light)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraint),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            nameNewsTitle.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: constraint),
            nameNewsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: constraint - 20),
            nameNewsTitle.topAnchor.constraint(equalTo: image.topAnchor),
            dateNewsTitle.heightAnchor.constraint(equalToConstant: 20),
            dateNewsTitle.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: constraint),
            dateNewsTitle.bottomAnchor.constraint(equalTo: image.bottomAnchor)
        ])
    }
    
    func configure(for model: News) {
        
        nameNewsTitle.text = model.nameNewsTitle
        dateNewsTitle.text = String(model.dateNewsTitle.dropLast(9).dropFirst(5))
        image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        image.sd_setImage(with: URL(string:model.image))
    }
}
