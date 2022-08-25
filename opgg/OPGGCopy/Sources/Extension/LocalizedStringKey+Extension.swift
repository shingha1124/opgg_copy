//
//  LocalizedStringKey+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

extension LocalizedStringKey {
    enum Keys {
        static let emptyText = LocalizedStringKey("")
        static let ladderRankPrefix = LocalizedStringKey("ladderRankPrefix")
        static let ladderRankSuffix = LocalizedStringKey("ladderRankSuffix")
        static let update = LocalizedStringKey("update")
        static let inGame = LocalizedStringKey("inGame")
        static let win = LocalizedStringKey("win")
        static let winCount = LocalizedStringKey("winCount")
        static let losses = LocalizedStringKey("losses")
        static let lossesCount = LocalizedStringKey("lossesCount")
    }
}

extension LocalizedStringKey {
    var value: String {
        let value = Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value
        guard let value = value as? String else {
            return ""
        }
        
        return NSLocalizedString(value, comment: "")
    }
}
