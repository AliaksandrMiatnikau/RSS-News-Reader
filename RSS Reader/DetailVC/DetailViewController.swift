//
//  DetailViewController1.swift
//  RSS Reader
//
//  Created by Aliaksandr Miatnikau on 3.02.23.
//

import Foundation
import UIKit
import SDWebImage

final class DetailViewController: UIViewController {

    // MARK: Properties
    
   private  let scrollView = UIScrollView()
    private let contentView = UIView()
    private var allNews: News?
    
    private let newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameNewsTitle: UILabel = {
        let label = UILabel()
            label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateNewsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textNewsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupViews()
        nameNewsTitle.text = allNews?.nameNewsTitle ?? ""
        dateNewsTitle.text = setDateFormat(text: allNews?.dateNewsTitle ?? "")
        textNewsTitle.text = allNews?.contentNews ?? ""
        newsImage.image = UIImage(systemName: "bell")
        newsImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        newsImage.sd_setImage(with: URL(string:allNews?.image ?? "https://icdn.lenta.ru/images/2023/02/02/13/20230202135544925/pic_d77cce1765cf6cced47468ebe7ea5a80.jpg"))
    }
    
    // MARK: Methods
    
    private func setDateFormat(text: String) -> String{
        let correctDate = String(text.dropLast(9).dropFirst(5))
        return correctDate
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupViews(){
        
        contentView.addSubview(newsImage)
        newsImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        newsImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        newsImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 18/20).isActive = true
        
        contentView.addSubview(nameNewsTitle)
        nameNewsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameNewsTitle.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5).isActive = true
        nameNewsTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 18/20).isActive = true
       
        
        contentView.addSubview(dateNewsTitle)
        dateNewsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateNewsTitle.topAnchor.constraint(equalTo: nameNewsTitle.bottomAnchor, constant: 10).isActive = true
        dateNewsTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 18/20).isActive = true
        
        contentView.addSubview(textNewsTitle)
        textNewsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textNewsTitle.topAnchor.constraint(equalTo: dateNewsTitle.bottomAnchor, constant: 25).isActive = true
        textNewsTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 18/20).isActive = true
        textNewsTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func set(news: News) {
        allNews = news
    }
}
