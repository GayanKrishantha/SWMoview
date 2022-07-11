// Created on 10/07/2022

import SwiftUI

struct FilmDetailView: View {
    @ObservedObject private(set) var viewModel: FilmDetailViewModel

    init(viewModel: FilmDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(viewModel.row, id: \.self) { value in
                    ListItem(
                        title: Text(value.title),
                        subtitle: Text(value.subtitle)
                    ).accessibilityIdentifier("listItem")
                }
            }
        }
    }
}
