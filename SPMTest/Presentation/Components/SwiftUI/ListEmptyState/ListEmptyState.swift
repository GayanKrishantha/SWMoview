// Created on 10/07/2022

import SwiftUI

struct ListEmptyState: View {
    var image: Image?
    let title: Text
    let subtitle: Text

    var body: some View {
        VStack(spacing: 24) {
            if let image = image {
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.neutral70)
            }

            VStack(spacing: 8) {
                title
                    .font(.heading1)
                    .foregroundColor(.neutral90)
                subtitle
                    .font(.paragraph1)
                    .lineHeight(for: .paragraph1)
                    .foregroundColor(.neutral70)
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
    }
}

struct EmptyListMessage_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyState(
            title: Text("Some title"),
            subtitle: Text("""
                            A message to display when there are no items in the list and you'd
                            like to explain the user what kind of data will be shown here.
                            """)
        )
    }
}
