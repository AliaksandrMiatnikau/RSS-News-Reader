//
//  NewsParcer.swift
//  RSS Reader
//
//  Created by Aliaksandr Miatnikau on 2.02.23.
//

import Foundation

final class NewsParser: NSObject, XMLParserDelegate {
    
    // MARK: Properties
    
    private var rssNews = [News]()
    private var currentElement = ""
    private var currentDict: [String : String] = [:]
    private var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var urlForImage = "" {
        
        didSet {
            urlForImage = urlForImage.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler: (([News]) -> ())?
    
    func parseNews(url: String, completionHandler: (([News]) -> ())?) {
        parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    // MARK: XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        currentDict = attributeDict
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title" : currentTitle += string
        case "description" : currentDescription += string
        case "pubDate" : currentPubDate += string
        case "enclosure" : urlForImage = currentDict["url"] ?? "https://play-lh.googleusercontent.com/uAu69C99ameBLdlE1Iv2ypibSqwQ3lqQGqm0NzcR1XpQ5gjBfNfW2sotbhfg2hPSjGZ3=w240-h480-rw"
        default : break
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssNews = News(nameNewsTitle: currentTitle, dateNewsTitle: currentPubDate, contentNews: currentDescription.description.html2String, image: urlForImage)
            self.rssNews.append(rssNews)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssNews)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

