//
//  String+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

//import SwiftUI
//
//extension String {
//    static func localized(_ localizedKey: LocalizedStringKey, _ args: [CVarArg]) -> String {
//        String(format: localizedKey.value, arguments: args)
//    }
//}
//
//extension String {
//    func attributedToOption(_ option: [AttributeOption] = []) -> AttributedString {
//        var attributeString = AttributedString(self)
//        option.forEach {
//            guard let range = attributeString.range(of: $0.text) else {
//                return
//            }
//            $0.options.forEach { option in
//                option.registOption(&attributeString[range])
//            }
//        }
//        return attributeString
//    }
//}
//
//struct AttributeOption {
//    let text: String
//    let options: [Option]
//}
//
//protocol Option {
//    func registOption(_ subString: inout AttributedSubstring)
//}
//
//struct ColorOption: Option {
//    let color: Color
//    
//    init(_ color: Color) {
//        self.color = color
//    }
//    
//    func registOption(_ subString: inout AttributedSubstring) {
//        subString.foregroundColor = color
//    }
//}
//
//struct FontOption: Option {
//    let font: Font
//    
//    init(_ font: Font) {
//        self.font = font
//    }
//    
//    func registOption(_ subString: inout AttributedSubstring) {
//        subString.font = font
//    }
//}
