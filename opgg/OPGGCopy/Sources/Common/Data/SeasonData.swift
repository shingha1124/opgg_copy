//
//  SeasonData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Foundation

final class SeasonData {
    
    private var data = [String: Season]()
    
    func updateData(_ data: [String: Season]) {
        self.data = data
    }
    
    subscript(_ id: Int) -> Season? {
        data[String(id)]
    }
}
