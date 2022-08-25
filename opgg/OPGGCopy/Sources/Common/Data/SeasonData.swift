//
//  SeasonData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Foundation

final class SeasonData {
    
    private var data = [Int: Season]()
    
    func updateData(_ data: [Season]) {
        self.data = data.reduce(into: [Int: Season]()) {
            $0[$1.id] = $1
        }
    }
    
    subscript(_ id: Int) -> Season? {
        data[id]
    }
}
