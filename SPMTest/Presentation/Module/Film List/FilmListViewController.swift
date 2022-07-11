// Created on 10/07/2022

import SwiftUI
import UIKit

final class FilmListViewController: UIHostingController<FilmListView> {
    private let viewModel: FilmListViewModel

    init(viewModel: FilmListViewModel) {
        self.viewModel = viewModel
        super.init(rootView: FilmListView(viewModel: viewModel))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Navigation.Title.movies
    }
}
