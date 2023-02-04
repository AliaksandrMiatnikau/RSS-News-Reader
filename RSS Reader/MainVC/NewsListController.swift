//
//  NewsListController.swift
//  RSS Reader
//
//  Created by Aliaksandr Miatnikau on 1.02.23.
//

import UIKit

final class NewsListController: UIViewController {
    
    // MARK: Properties
    
    private var tableView = UITableView()
    private var newsArray: [News]?
    private var url = "https://lenta.ru/rss/news"
    private let reuseIdentifier = "NewsCell"
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationController()
        fetchData(url: url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: Methods
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 120
        tableView.register(ContentsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.pin(to: view)
        tableView.addSubview(refreshControl)
    }
    
    private func configureNavigationController() {
        
        title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Source", style: .plain, target: self, action: #selector(choseSource))
    }
    
    private func setTableViewDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData(url: String) {
        
        let newsParser = NewsParser()
        newsParser.parseNews(url: url) { [weak self] allNews in
            self?.newsArray = allNews
            OperationQueue.main.addOperation {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
            }
        }
    }
    // MARK: objc methods
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchData(url: url)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc private func choseSource() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let sourceOne = UIAlertAction(title: "Лента", style: .default) { [weak self] _ in
            let url = "https://lenta.ru/rss/news"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let sourceTwo = UIAlertAction(title: "Ведомости", style: .default) { [weak self] _ in
            let url = "https://www.vedomosti.ru/rss/articles.xml"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let sourceThree = UIAlertAction(title: "News.ru", style: .default) { [weak self] _ in
            let url = "https://news.ru/rss/"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let sourceFour = UIAlertAction(title: "Коммерсант", style: .default) { [weak self] _ in
            let url = "https://www.kommersant.ru/rss/main.xml"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(sourceOne)
        actionSheet.addAction(sourceTwo)
        actionSheet.addAction(sourceThree)
        actionSheet.addAction(sourceFour)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true)
    }
}

// MARK: UITableViewDataSource

extension NewsListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allNews = newsArray else { return 0 }
        return allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContentsCell
        if let news = newsArray?[indexPath.row] {
            cell.configure(for: news)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailNewsController = DetailViewController()
        if let news = newsArray?[indexPath.row] {
            detailNewsController.set(news: news)
        }
        
        if indexPath == tableView.indexPathForSelectedRow {
            newsArray?.remove(at: indexPath.row)
            detailNewsController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(detailNewsController, animated: true)
        }
    }
}
