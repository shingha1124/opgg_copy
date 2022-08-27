//
//  LocalizedKey+Text+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/26.
//

import SwiftUI

protocol HtmlOption {
    var optionString: String { get }
}

struct ColorOption: HtmlOption {
    let color: Color
    
    var optionString: String {
        "color: \(color.hexColor);"
    }
    
    init(_ color: Color) {
        self.color = color
    }
}

struct FontOption: HtmlOption {
    let font: HtmlFont
    let size: Int
    
    var optionString: String {
        "font-family: \(font.rawValue); font-size: \(size);"
    }
    
    init(_ font: HtmlFont = .system, size: Int = 10) {
        self.font = font
        self.size = size
    }
}

@frozen
enum HtmlFont: String {
    case system = "-apple-system"
}

extension Text {
    init(key: LocalizedKey) {
        let text = key.value
        self.init(text)
    }
    
    init(key: LocalizedKey, args: [CVarArg], options: [HtmlOption] = [
        FontOption(.system),
        ColorOption(.black)
    ]) {
        var text = String(format: key.value, args)
        
        let prefix = "html:"
        if text.hasPrefix(prefix) {
            text = String(text.dropFirst(prefix.count))
            
            if !options.isEmpty {
                let optionText = options.map {
                    $0.optionString + " "
                }.joined()
                
                text = "<span style=\"\(optionText)\">\(text)</span>"
            }
            
            guard let data = text.data(using: .utf8),
                  let htmlString = try? NSAttributedString(
                    data: data,
                    options: [
                        .documentType: NSAttributedString.DocumentType.html,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil) else {
                self.init(text)
                return
            }
            
            self.init(AttributedString(htmlString))
        } else {
            self.init(text)
        }
    }
}
