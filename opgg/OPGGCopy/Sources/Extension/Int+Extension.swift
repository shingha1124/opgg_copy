//
//  Int+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

protocol Currency { }

extension Currency {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let stringPrice = formatter.string(for: self) else {
            return ""
        }
        return stringPrice
    }
}

extension UInt: Currency { }
extension Int: Currency { }
