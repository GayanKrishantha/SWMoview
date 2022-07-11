// Created on 09/07/2022

import SwiftUI

protocol ProgressChapter {
    var name: String { get }
    var nameColor: Color { get }
    var indexImage: Image? { get }
    var indexColor: Color { get }
    var asNotStarted: Self { get }
    var asActive: Self { get }
    var asCompleted: Self { get }
}
