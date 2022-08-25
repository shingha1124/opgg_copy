//
//  ChampionData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Foundation

final class ChampionData {
    
    private var data = [Int: Champion]()
    
    func updateData(_ data: [Champion]) {
        self.data = data.reduce(into: [Int: Champion]()) {
            $0[$1.id] = $1
        }
    }
    
    subscript(_ id: Int) -> Champion? {
        data[id]
    }
}
