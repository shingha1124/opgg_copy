//
//  SpellData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Foundation

final class SpellData {
    
    private var data = [Int: Spell]()
    
    func updateData(_ data: [String: Spell]) {
        self.data = data.reduce(into: [Int: Spell]()) {
            $0[$1.value.id] = $1.value
        }
    }
    
    subscript(_ id: Int) -> Spell? {
        data[id]
    }
}
