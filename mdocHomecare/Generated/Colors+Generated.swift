//
//  ColorExtension.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/05/02.
//

import UIKit

enum Colors {
    
    enum Text {
        static var mainContent: UIColor {
            return color(
                light: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1),
                dark: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
            )
        }
        static var subContent: UIColor {
            return color(
                light: UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1),
                dark: UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1)
            )
        }
        static var blueSubContent: UIColor {
            return color(
                light: UIColor(red: 0.44, green: 0.52, blue: 0.87, alpha: 1),
                dark: UIColor(red: 0.44, green: 0.52, blue: 0.87, alpha: 1)
            )
        }
    }
    enum Layout {
        static var I0: UIColor {
            return color(
                light: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1),
                dark: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            )
        }
        static var I5: UIColor {
            return color(
                light: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1),
                dark: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
            )
        }
        
        static var I20: UIColor {
            return color(
                light: UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1),
                dark: UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
            )
        }
    }
    enum Semantic {
        static var mdocBlue: UIColor {
            return color(
                light: UIColor(red: 0.2, green: 0.31, blue: 0.82, alpha: 1),
                dark: UIColor(red: 0.2, green: 0.31, blue: 0.82, alpha: 1)
            )
        }
    }
}

extension Colors {
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            switch UITraitCollection.userInterfaceStyle {
            case .light: return light
            case .dark: return dark
            default: return light
            }
        }
    }
}
