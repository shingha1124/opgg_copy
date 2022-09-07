//
//  Model+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Foundation
import SwiftUI

extension GameResult {
    var color: Color {
        self == .win ? .blue42 : .red229
    }
}

extension Date {
    var createDateToValue: String {
        let diff = Calendar.current.dateComponents([.minute, .hour, .day], from: self, to: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        
        var createAtText = dateFormatter.string(from: self)
        
        if let day = diff.day, day > 1 {
            if day <= 7 {
                createAtText = String(format: LocalizedKey.dayAgo.value, day)
            }
        } else if let hour = diff.hour, hour > 1 {
            createAtText = String(format: LocalizedKey.hourAgo.value, hour)
        } else if let minute = diff.minute {
            createAtText = String(format: LocalizedKey.minuteAgo.value, minute)
        } else {
            createAtText = "방금 전"
        }
        
        return createAtText
    }
}
