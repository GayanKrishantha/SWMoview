// Created on 10/07/2022

import SwiftUI
import UIKit

final class FilmDetailViewController: UIHostingController<FilmDetailView> {
    private let viewModel: FilmDetailViewModel

    init(viewModel: FilmDetailViewModel) {
        self.viewModel = viewModel
        super.init(rootView: FilmDetailView(viewModel: viewModel))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.film?.title ?? L10n.Label.notAvailable
    }
}
