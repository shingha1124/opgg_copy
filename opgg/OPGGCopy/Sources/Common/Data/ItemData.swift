//
//  ItemData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Foundation

final class ItemData {
    
    private var data = [Int: ItemDatum]()
    
    func updateData(_ data: [String: ItemDatum]) {
        self.data = data.reduce(into: [Int: ItemDatum]()) {
            $0[$1.value.id] = $1.value
        }
    }
    
    subscript(_ id: Int) -> ItemDatum? {
        data[id]
    }
}
