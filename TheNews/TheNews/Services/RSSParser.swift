//
//  RSSParser.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation

class RSSParser: NSObject, XMLParserDelegate {
    
    private var news = RealmManager.news
    private var newsArray: [NewsModel] = []
    private let fetchDataService = FetchDataService(NetworkService())
    
    private var currentElement = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    
    func refreshNews(urlString: String, completion: @escaping ([NewsModel]) -> Void) {
        
        news = realm.objects(NewsModel.self)
        RealmManager.deleteAll(news)
        
        newsArray = []
        self.fetchDataService.fetchData(urlString: urlString) { [self] (data) in
            guard let data = data else { return }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            completion(newsArray)
        }
    }
}

// MARK: - XML Parser Delegate

extension RSSParser {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        
        case "title":
            currentTitle += string
        case "description" :
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            let newsItem = NewsModel(title: currentTitle, date: currentPubDate, desc: currentDescription, isReading: false, isFavourite: false)
            RealmManager.saveObject(newsItem)
        }
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print(validationError.localizedDescription)
    }
    
}
