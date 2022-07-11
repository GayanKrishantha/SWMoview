// Created on 10/07/2022

import Lottie
import SwiftUI

struct LottieAnimation: UIViewRepresentable {
    var animation: Lottie.Animation?
    var loopMode: LottieLoopMode
    var isPlaying: Bool = true

    func makeUIView(context _: Context) -> AnimationView {
        let animationView = AnimationView(animation: animation)
        animationView.loopMode = loopMode
        animationView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        animationView.setContentHuggingPriority(.defaultLow, for: .vertical)
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return animationView
    }

    func updateUIView(_ animationView: AnimationView, context _: Context) {
        animationView.loopMode = loopMode
        isPlaying ? animationView.play() : animationView.stop()
    }
}
