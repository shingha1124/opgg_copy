//
//  IntegrateTextView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct ParsedText {
    var text: String = ""
    var color: UIColor = .black
    var font: UIFont = .systemFont(ofSize: 10, weight: .regular)
}

struct IntegrateTextView: UIViewRepresentable {
    let parsedTextList: [ParsedText]
    
    func makeUIView(context: Context) -> UILabel {
        UILabel()
    }
    
    func updateUIView(_ label: UILabel, context: Context) {
        let result = parsedTextList.map { text -> NSAttributedString in
            let attribute = processAttribute(text: text)
            let attributeString = NSMutableAttributedString(string: text.text)
            attributeString.addAttributes(attribute, range: NSRange(location: 0, length: attributeString.length))
            return attributeString
        }.reduce(into: NSMutableAttributedString()) {
            $0.append($1)
        }
        
        label.attributedText = result
    }
    
    func processAttribute(text: ParsedText) -> [NSAttributedString.Key: Any] {
        var final = [NSAttributedString.Key: Any]()
        final[NSAttributedString.Key.foregroundColor] = text.color
        final[NSAttributedString.Key.font] = text.font
        return final
    }
}
