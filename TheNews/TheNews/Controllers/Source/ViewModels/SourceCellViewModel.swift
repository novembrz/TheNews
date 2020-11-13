//
//  SourceCellViewModel.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import Foundation

protocol SourceCellViewModelType: class {
    var title: String { get }
    var url: String { get }
    var isCurrent: Bool  { get }
}

class SourceCellViewModel: SourceCellViewModelType {

    private var source: SourceModel

    var title: String {
        return source.title
    }

    var url: String {
        return source.url
    }

    var isCurrent: Bool {
        return source.isCurrent
    }

    init (source: SourceModel) {
        self.source = source
    }
}
