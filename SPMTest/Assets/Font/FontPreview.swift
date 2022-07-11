// Created on 09/07/2022

import SwiftUI

struct Font_Previews: PreviewProvider {
    static var fonts: [(font: Font, text: String)] {
        [
            (.heading1, "Heading 1"),
            (.heading2, "Heading 2"),
            (.paragraph1, "Paragraph 1"),
            (.paragraph2, "Paragraph 2"),
            (.labelSmall, "Label Small"),
            (.labelMedium, "Label Medium"),
            (.labelLarge, "Label Large")
        ]
    }

    static var previews: some View {
        Group {
            ForEach(fonts, id: \.text) { font, text in
                Group {
                    VStack {
                        Text(text)
                            .environment(\.sizeCategory, .small)
                        Text(text)
                        Text(text)
                            .environment(\.sizeCategory, .extraLarge)
                        Text(text)
                            .environment(\.sizeCategory, .extraExtraExtraLarge)
                        Text(text)
                            .environment(\.sizeCategory, .accessibilityLarge)
                        Text(text)
                            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                    }
                    .font(font)
                }
                .padding()
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
