//
//  Color+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import SwiftUI

extension Color {
    static let greenBlue = color(r: 10, g: 197, b: 142)
    static let darkishPink = color(r: 232, g: 64, b: 87)
    static let orangeYellow = color(r: 255, g: 169, b: 5)
    static let periwinkle = color(r: 139, g: 104, b: 255)
    static let softBlue = color(r: 83, g: 131, b: 232)
    
    static let blue1 = color(r: 42, g: 97, b: 241)
    static let blue2 = color(r: 67, g: 118, b: 248)
    
    static let darkgrey = color(r: 30, g: 32, b: 34)
    static let charcoalGrey = color(r: 51, g: 56, b: 60)
    static let gunmetal = color(r: 82, g: 89, b: 95)
    static let steelGrey = color(r: 123, g: 133, b: 142)
    static let coolGrey = color(r: 152, g: 160, b: 167)
    static let paleGrey2 = color(r: 235, g: 238, b: 241)
    static let paleGrey1 = color(r: 247, g: 247, b: 249)
    
    static let systemPaleGrey = Color("paleGrey")
    static let systemDarkgrey = Color("darkgrey")
    
    static let systemBackground1 = Color("background1")
    static let systemBackground2 = Color("background2")
    
    private static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> Color {
        Color(.sRGB, red: r / 255, green: g / 255, blue: b / 255, opacity: a)
    }
    
    var uiColor: UIColor {
        UIColor(self)
    }
    
    static func liner(from: Color, to: Color, value: CGFloat) -> Color {
        let fromColor = from.components
        let toColor = to.components
        
        let r: CGFloat = fromColor.red * (1.0 - value) + toColor.red * value
        let g: CGFloat = fromColor.green * (1.0 - value) + toColor.green * value
        let b: CGFloat = fromColor.blue * (1.0 - value) + toColor.blue * value
        let o: CGFloat = fromColor.opacity * (1.0 - value) + toColor.opacity * value
        
        return Color(.sRGB, red: r, green: g, blue: b, opacity: o)
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }
}
