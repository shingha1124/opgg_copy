//
//  RuneData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Foundation

final class RuneData {
    
    private var data = [Int: RuneDatum]()
    
    func updateData(_ data: [String: RuneDatum]) {
        self.data = data.reduce(into: [Int: RuneDatum]()) {
            $0[$1.value.id] = $1.value
        }
    }
    
    subscript(_ id: Int) -> RuneDatum? {
        data[id]
    }
}
