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

struct FilmDetailView_Previews: PreviewProvider {
    private static var viewModel: FilmDetailViewModel {
        let film = Film(title: "Test",
                        episodeId: 2,
                        openingCrawl: "It is  to the galaxy....",
                        director: "George Lucas",
                        producer: "Gary Kurtz, Rick McCallum",
                        releaseDate: "1977-05-25",
                        created: "2014-12-10T14:23:31.880000Z",
                        edited: "2014-12-20T19:49:45.256000Z",
                        url: "https://swapi.dev/api/films/1/")
        return FilmDetailViewModel(film: film)
    }
    
    static var previews: some View {
        Group {
            FilmDetailView(viewModel: viewModel)
                .previewDevice("iPhone 12")

            FilmDetailView(viewModel: viewModel)
                .previewDevice("iPhone 12 Pro Max")

            FilmDetailView(viewModel: viewModel)
                .previewDevice("iPhone SE (2nd generation)")

            FilmDetailView(viewModel: viewModel)
                .previewDevice("iPhone SE (1st generation)")
        }.previewLayout(.sizeThatFits)
         .padding()
    }
}
