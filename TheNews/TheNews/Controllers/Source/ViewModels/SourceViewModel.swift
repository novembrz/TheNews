//
//  SourceViewModel.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import Foundation

protocol SourceViewModelType {

    var sources: [SourceModel] { get set }
    var currentSource: SourceModel? { get set }
    func numberOfRows() -> Int
    func saveSourcesInUserDefaults()
    func loadSources()
    func refreshIsCurrent()
    func setIsCurrent()

}

class SourceViewModel: SourceViewModelType {

    var sources = [
        SourceModel(title: "Banki.ru", url: CurrentURL.getBankiURlString(), isCurrent: true),
        SourceModel(title: "Finam.ru", url: CurrentURL.getFinamURlString(), isCurrent: false)
    ]

    var currentSource: SourceModel?

    func numberOfRows() -> Int {
        return sources.count
    }
    
    
    func saveSourcesInUserDefaults() {
        var sourcesTitle: [String] = []
        var sourcesURL: [String] = []
        
        for i in 0..<sources.count {
            sourcesTitle.append(sources[i].title)
            sourcesURL.append(sources[i].url)
        }
        UserDefaultManager.saveSources(sourcesTitle: sourcesTitle, sourcesURL: sourcesURL)
    }
    
    
    func loadSources() {
        sources = []
        let title = UserDefaultManager.getSourcesTitle()
        let url = UserDefaultManager.getSourcesURL()
        
        if !title.isEmpty {
            for i in 0..<title.count {
                sources.append(SourceModel(title: title[i], url: url[i], isCurrent: false))
            }
        }
    }
    
    func refreshIsCurrent() {
        if !sources.isEmpty {
            for i in 0..<sources.count {
                sources[i].isCurrent = false
            }
        }
    }
    
    func setIsCurrent() {
        if !sources.isEmpty {
            sources[0].isCurrent = true
        }
    }
}

