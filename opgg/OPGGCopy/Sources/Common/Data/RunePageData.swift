//
//  RunePageData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Foundation

final class RunePageData {
    
    private var data = [Int: RunePageDatum]()
    
    func updateData(_ data: [String: RunePageDatum]) {
        self.data = data.reduce(into: [Int: RunePageDatum]()) {
            $0[$1.value.id] = $1.value
        }
    }
    
    subscript(_ id: Int) -> RunePageDatum? {
        data[id]
    }
}
