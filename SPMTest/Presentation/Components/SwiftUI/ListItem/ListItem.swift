// Created on 10/07/2022

import SwiftUI

struct ListItem: View {
    struct Badge: View {
        let text: Text
        let backgroundColor: Color

        var body: some View {
            text
                .font(.labelLarge)
                .foregroundColor(.neutral00)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(backgroundColor)
                )
        }
    }

    private var image: Image?
    private var leadingView: AnyView?
    private var title: Text
    private var subtitle: Text?
    private var badge: Badge?
    private var trailingView: AnyView?
    private var showDisclosureIndicator: Bool
    private var showDivider: Bool
    private var isSelected: Bool
    private var action: (() -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            if let action = action {
                Button(action: action) {
                    content
                }
                .contentShape(Rectangle())
            } else {
                content
            }

            if showDivider {
                Divider()
            }
        }
        .enabled(action != nil)
        .padding(.horizontal, 24)
    }

    private var content: some View {
        HStack(spacing: 16) {
            leadingView

            image?
                .resizable()
                .scaledToFit()
                .foregroundColor(.neutral70)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 3) {
                title
                    .font(subtitle != nil ? .heading3 : .paragraph1)
                    .foregroundColor(isSelected ? .neutral40 : .neutral90)

                subtitle?
                    .font(.paragraph2)
                    .foregroundColor(isSelected ? .neutral40 : .neutral70)
            }
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)

            badge

            trailingView

            if isSelected {
                Image.Icons.Arrow.right
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.neutral40)
            }

            if showDisclosureIndicator {
                Image.Icons.Arrow.right
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.neutral40)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.vertical, 16)
    }
}

extension ListItem {
    init(
        image: Image? = nil,
        title: Text,
        subtitle: Text? = nil,
        badge: Badge? = nil,
        showDisclosureIndicator: Bool = false,
        showDivider: Bool = true,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.showDisclosureIndicator = showDisclosureIndicator
        self.showDivider = showDivider
        self.isSelected = isSelected
        self.action = action
    }

    init<Trailing: View>(
        image: Image? = nil,
        title: Text,
        subtitle: Text? = nil,
        badge: Badge? = nil,
        trailingView: Trailing,
        showDisclosureIndicator: Bool = false,
        showDivider: Bool = true,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.showDisclosureIndicator = showDisclosureIndicator
        self.showDivider = showDivider
        self.isSelected = isSelected
        self.action = action
        self.trailingView = AnyView(trailingView)
    }

    init<Leading: View>(
        leadingView: Leading,
        title: Text,
        subtitle: Text? = nil,
        badge: Badge? = nil,
        showDisclosureIndicator: Bool = false,
        showDivider: Bool = true,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.leadingView = AnyView(leadingView)
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.showDisclosureIndicator = showDisclosureIndicator
        self.showDivider = showDivider
        self.isSelected = isSelected
        self.action = action
    }

    init<Trailing: View>(
        trailingView: Trailing,
        title: Text,
        subtitle: Text? = nil,
        badge: Badge? = nil,
        showDisclosureIndicator: Bool = false,
        showDivider: Bool = true,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.trailingView = AnyView(trailingView)
        self.showDisclosureIndicator = showDisclosureIndicator
        self.showDivider = showDivider
        self.isSelected = isSelected
        self.action = action
    }

    init<Leading: View, Trailing: View>(
        leadingView: Leading? = nil,
        title: Text,
        subtitle: Text? = nil,
        badge: Badge? = nil,
        trailingView: Trailing? = nil,
        showDisclosureIndicator: Bool = false,
        showDivider: Bool = true,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.leadingView = AnyView(leadingView)
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.trailingView = AnyView(trailingView)
        self.showDisclosureIndicator = showDisclosureIndicator
        self.isSelected = isSelected
        self.showDivider = showDivider
        self.action = action
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListItem(
                title: Text("Some title"),
                action: {}
            )
            ListItem(
                title: Text("Some title"),
                subtitle: Text("Some subtitle"),
                action: {}
            )
            ListItem(
                title: Text("Some title"),
                subtitle: Text("Some subtitle Some subtitle Some subtitle Some subtitle Some subtitle Some subtitle"),
                action: {}
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
