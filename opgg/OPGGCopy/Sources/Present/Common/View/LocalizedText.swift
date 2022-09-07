//
//  LocalizedText.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import SwiftUI

private class LocalizedOption {
    private(set) var color: Color = .black
    private(set) var font: HtmlFont = .system
    private(set) var fontSize: Int = 10
    private(set) var fontWeight: HtmlFontWeight = .regular
    
    func updateFont(font: HtmlFont, size: Int) {
        self.font = font
        self.fontSize = size
    }
    
    func updateWeight(weight: HtmlFontWeight) {
        self.fontWeight = weight
    }
    
    func updateColor(_ color: Color) {
        self.color = color
    }
}

@frozen
enum HtmlFont: String {
    case system = "-apple-system"
}

@frozen
enum HtmlFontWeight: String {
    case regular = "300"
    case bold = "600"
}

struct LocalizedText: UIViewRepresentable {
    private let text: String
    
    private let localizedOption = LocalizedOption()
    
    init(_ text: String) {
        self.text = text
    }
    
    init(key: LocalizedKey) {
        self.text = key.value
    }

    init(_ key: LocalizedKey, args: [CVarArg] = []) {
        self.text = String(format: key.value, args)
    }
    
    func makeUIView(context: Context) -> UILabel {
        UILabel()
    }

    func updateUIView(_ uiLabel: UILabel, context: Context) {
        let htmlText = """
<span style=\"
font-family: \(localizedOption.font.rawValue);
font-size: \(localizedOption.fontSize);
font-weight: \(localizedOption.fontWeight.rawValue);
color: \(localizedOption.color.hexColor);\">\(text)</span>
"""
        
        DispatchQueue.main.async {
            guard let data = htmlText.data(using: .utf8),
                  let htmlString = try? NSAttributedString(
                    data: data,
                    options: [
                        .documentType: NSAttributedString.DocumentType.html,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil) else {
                uiLabel.text = text
                return
            }
            
            uiLabel.attributedText = htmlString
            uiLabel.numberOfLines = 0
        }
    }
    
    func font(font: HtmlFont = .system, size: Int = 10) -> LocalizedText {
        localizedOption.updateFont(font: font, size: size)
        return self
    }
    
    func bold() -> LocalizedText {
        localizedOption.updateWeight(weight: .bold)
        return self
    }
    
    func color(_ color: Color) -> LocalizedText {
        localizedOption.updateColor(color)
        return self
    }
}
