// Created on 10/07/2022

import SwiftUI

struct ProgressChapterView: View {
    static var height: CGFloat { 68 }

    @ObservedObject var viewModel: ProgressChapterViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(0 ..< viewModel.chapters.count, id: \.self) { index in
                let chapter = viewModel.chapters[index]
                VStack(spacing: 4) {
//                    Group {
//                        if let image = chapter.indexImage {
//                            image
//                                .resizable()
//                                .scaledToFit()
//                        } else {
//                            Text(String(index + 1))
//                                .font(.labelLarge)
//                                .transition(
//                                    .asymmetric(
//                                        insertion: .move(edge: .bottom),
//                                        removal: .move(edge: .top)
//                                    )
//                                    .combined(with: .opacity)
//                                )
//                        }
//                    }
                    // .foregroundColor(chapter.indexColor)
                    // .frame(height: 16)

                    Text(chapter.name)
                        // .font(.labelMedium)
                        .foregroundColor(
                            chapter.nameColor
                        )
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .animation(.easeInOut, value: hashValue(of: chapter))
            }
        }
        .padding([.horizontal], 24)
        .frame(maxWidth: .infinity)
        .frame(height: ProgressChapterView.height)
        .background(Color.neutral10)
    }

    private func hashValue(of chapter: ProgressChapter) -> Int {
        var hasher = Hasher()
        hasher.combine(chapter.name)
        hasher.combine(chapter.nameColor)
        hasher.combine(chapter.indexColor)
        return hasher.finalize()
    }
}

struct RegistrationProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressChapterView(
                viewModel: ProgressChapterViewModel(
                    chapters: [
                        DefaultProgressChapter.account.asActive,
                        DefaultProgressChapter.payment,
                        DefaultProgressChapter.license,
                        DefaultProgressChapter.drive
                    ]
                )
            )
            .frame(width: 320)
            ProgressChapterView(
                viewModel: ProgressChapterViewModel(
                    chapters: [
                        DefaultProgressChapter.account.asCompleted,
                        DefaultProgressChapter.payment.asActive,
                        DefaultProgressChapter.license,
                        DefaultProgressChapter.drive
                    ]
                )
            )
            .frame(width: 350)
            ProgressChapterView(
                viewModel: ProgressChapterViewModel(
                    chapters: [
                        DefaultProgressChapter.account.asCompleted,
                        DefaultProgressChapter.payment.asCompleted,
                        DefaultProgressChapter.license.asActive,
                        DefaultProgressChapter.drive
                    ]
                )
            )

            ProgressChapterView(
                viewModel: ProgressChapterViewModel(
                    chapters: [
                        DefaultProgressChapter.account.asCompleted,
                        DefaultProgressChapter.payment.asCompleted,
                        DefaultProgressChapter.license.asCompleted,
                        DefaultProgressChapter.drive.asActive
                    ]
                )
            )
            .frame(width: 450)
        }
        .previewLayout(.sizeThatFits)
    }
}

private extension DefaultProgressChapter {
    static var account: DefaultProgressChapter {
        DefaultProgressChapter("Account")
    }

    static var payment: DefaultProgressChapter {
        DefaultProgressChapter("Payment")
    }

    static var license: DefaultProgressChapter {
        DefaultProgressChapter("License")
    }

    static var drive: DefaultProgressChapter {
        DefaultProgressChapter("Drive", Image.Icons.Arrow.right)
    }
}
