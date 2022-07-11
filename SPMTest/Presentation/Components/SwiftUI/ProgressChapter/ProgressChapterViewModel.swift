// Created on 10/07/2022

import SwiftUI

class ProgressChapterViewModel: ObservableObject {
    @Published private(set) var chapters: [ProgressChapter]
    private var activeIndex: Int = 0 {
        didSet {
            update(chapters: chapters, activeIndex: activeIndex)
        }
    }

    init(chapters: [ProgressChapter] = []) {
        self.chapters = chapters
    }

    func updateActive(to activeIndex: Int) {
        self.activeIndex = activeIndex
    }

    func updateChapters(to chapters: [ProgressChapter]) {
        update(chapters: chapters, activeIndex: activeIndex)
    }

    private func update(chapters: [ProgressChapter], activeIndex: Int) {
        self.chapters = chapters.enumerated().map { index, element in
            if index < activeIndex {
                return element.asCompleted
            } else if index == activeIndex {
                return element.asActive
            } else {
                return element.asNotStarted
            }
        }
    }
}
