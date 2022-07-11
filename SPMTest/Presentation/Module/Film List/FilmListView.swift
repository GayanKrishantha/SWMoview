// Created on 10/07/2022

import SwiftUI

struct FilmListView: View {
    @ObservedObject private(set) var viewModel: FilmListViewModel

    @State private var searchText = ""

    init(viewModel: FilmListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewModel.isLoading {
                listLoader.accessibilityIdentifier("listLoader")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    movieListSearch.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always )).accessibilityIdentifier("movieListSearch")
                }
                Spacer()
            }
        }
        .padding(.top, 0)
        .background(Color.neutral10.edgesIgnoringSafeArea(.bottom))
        .onAppear(perform: viewModel.onAppear)
    }
    
    var movieListSearch: some View {
        ForEach(viewModel.searchResults(allFilms: viewModel.films,
                                        searchText: searchText), id: \.episodeId) { film in
            ListItem(
                title: Text(film.title ?? ""),
                subtitle: Text("\(L10n.Label.episode) \(Int(film.episodeId ?? 0))"),
                showDisclosureIndicator: true,
                action: {
                    viewModel.showDeils(film: film)
                }
            ).accessibilityIdentifier("listItem")
        }
    }

    var listLoader: some View {
        VStack {
            Spacer()
            Loader(style: .dark, size: .regular)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

