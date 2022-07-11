// Created on 09/07/2022

import SwiftUI

struct FontType {
    let name: String
    let size: CGFloat
    var lineHeightMultiple: CGFloat = 1.3
    var lineSpacing: CGFloat {
        size * lineHeightMultiple - size
    }

    static func sourceSansPro(_ type: SourceSansPro, size: CGFloat) -> FontType {
        FontType(name: type.name, size: size)
    }

    static var heading1: FontType {
        .sourceSansPro(.bold, size: 24)
    }

    static var heading2: FontType {
        .sourceSansPro(.bold, size: 20)
    }

    static var heading3: FontType {
        .sourceSansPro(.bold, size: 14)
    }

    static var paragraph1: FontType {
        .sourceSansPro(.regular, size: 16)
    }

    static var paragraph2: FontType {
        .sourceSansPro(.regular, size: 14)
    }

    static var labelLarge: FontType {
        .sourceSansPro(.bold, size: 14)
    }

    static var labelMedium: FontType {
        .sourceSansPro(.bold, size: 12)
    }

    static var labelSmall: FontType {
        .sourceSansPro(.bold, size: 10)
    }

    func font(forTextStyle textStyle: UIFont.TextStyle? = nil) -> UIFont {
        let font = UIFont(name: name, size: size)!
        if let textStyle = textStyle {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        } else {
            return font
        }
    }

    func font(forTextStyle textStyle: Font.TextStyle? = nil) -> Font {
        guard let textStyle = textStyle else {
            return .custom(name, size: size)
        }
        if #available(iOS 14.0, *) {
            return .custom(name, size: size, relativeTo: textStyle)
        } else {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return .custom(name, size: scaledSize)
        }
    }
}

extension UIFont {
    static func sourceSansPro(_ type: SourceSansPro,
                              size: CGFloat, forTextStyle
                              textStyle: UIFont.TextStyle? = nil) -> UIFont {
        FontType.sourceSansPro(type, size: size).font(forTextStyle: textStyle)
    }

    static var heading1: UIFont {
        FontType.heading1.font(forTextStyle: .largeTitle)
    }

    static var heading2: UIFont {
        FontType.heading2.font(forTextStyle: .headline)
    }

    static var heading3: UIFont {
        FontType.heading3.font(forTextStyle: .headline)
    }

    static var paragraph1: UIFont {
        FontType.paragraph1.font(forTextStyle: .body)
    }

    static var paragraph2: UIFont {
        FontType.paragraph2.font(forTextStyle: .body)
    }

    static var labelLarge: UIFont {
        FontType.labelLarge.font(forTextStyle: .body)
    }

    static var labelMedium: UIFont {
        FontType.labelLarge.font(forTextStyle: .body)
    }

    static var labelSmall: UIFont {
        FontType.labelSmall.font(forTextStyle: .body)
    }
}

extension Font {
    static func sourceSansPro(_ type: SourceSansPro,
                              size: CGFloat, forTextStyle
                              textStyle: Font.TextStyle? = nil) -> Font {
        FontType.sourceSansPro(type, size: size).font(forTextStyle: textStyle)
    }

    static var heading1: Font {
        FontType.heading1.font(forTextStyle: .largeTitle)
    }

    static var heading2: Font {
        FontType.heading2.font(forTextStyle: .headline)
    }

    static var heading3: Font {
        FontType.heading3.font(forTextStyle: .headline)
    }

    static var paragraph1: Font {
        FontType.paragraph1.font(forTextStyle: .body)
    }

    static var paragraph2: Font {
        FontType.paragraph2.font(forTextStyle: .body)
    }

    static var labelLarge: Font {
        FontType.labelLarge.font(forTextStyle: .body)
    }

    static var labelMedium: Font {
        FontType.labelMedium.font(forTextStyle: .body)
    }

    static var labelSmall: Font {
        FontType.labelSmall.font(forTextStyle: .body)
    }
}
