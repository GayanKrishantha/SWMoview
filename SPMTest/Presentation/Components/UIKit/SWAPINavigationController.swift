// Created on 09/07/2022

import SnapKit
import SwiftUI
import UIKit

final class SWAPINavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        topViewController
    }

    convenience init() {
        self.init(style: .opaque)
    }

    init(style: UINavigationBar.Style) {
        super.init(nibName: nil, bundle: nil)

        navigationBar.apply(style: style)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var progressChapterView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
        }
    }

    func showProgressChapters(viewModel: ProgressChapterViewModel) {
        guard progressChapterView == nil else { return }

        progressChapterView = UIView { view in
            let progressViewController = UIHostingController(
                rootView: ProgressChapterView(viewModel: viewModel)
            )
            view.addSubview(progressViewController.view)
            progressViewController.view.snp.makeConstraints {
                $0.top.equalToSuperview().priority(.low)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            view.clipsToBounds = true
        }

        var heightConstraint: Constraint?

        navigationBar.addSubview(progressChapterView!)
        progressChapterView?.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            heightConstraint = $0.height.equalTo(0).constraint
        }
        progressChapterView?.superview?.layoutIfNeeded()

        heightConstraint?.deactivate()
        UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseInOut) { [weak self] in
            self?.progressChapterView?.superview?.layoutIfNeeded()
        }
    }

    func hideProgressChapters() {
        guard let progressChapterView = progressChapterView else { return }
        progressChapterView.snp.remakeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }

        UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseInOut) {
            progressChapterView.superview?.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.progressChapterView = nil
        }
    }
}
