//
//  String+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

extension String {
    static func localized(_ localizedKey: LocalizedStringKey, args: [CVarArg]) -> String {
        String(format: localizedKey.value, arguments: args)
    }
}
