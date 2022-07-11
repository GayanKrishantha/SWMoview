// Created on 09/07/2022

import CoreServices
import SwiftUI
import UIKit

extension UIImage {
    private static var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.compactMap { $0.delegate as? SceneDelegate }.first }

    static func from<Content: View>(_ content: Content) -> UIImage {
        let viewController = UIHostingController(rootView: content)
        let view: UIView = viewController.view
        view.backgroundColor = .clear

        let contentSize = view.intrinsicContentSize
        if #available(iOS 15.0, *) {
            let safeAreaInsets = sceneDelegate?.keyWindow?.safeAreaInsets ?? .zero
            // Move the frame of the view down to offset the top edge safe area inset
            view.frame = CGRect(
                origin: CGPoint(x: .zero, y: safeAreaInsets.top),
                size: contentSize
            )
        } else {
            view.bounds = CGRect(
                origin: .zero,
                size: contentSize
            )
        }

        let renderer = UIGraphicsImageRenderer(size: contentSize)
        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }

    func crop(to rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage else { return nil }

        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        let cropRect = CGRect(
            x: rect.origin.x * width,
            y: rect.origin.y * height,
            width: rect.size.width * width,
            height: rect.size.height * height
        )

        guard let croppedCGImage = cgImage.cropping(to: cropRect) else {
            return nil
        }

        return UIImage(
            cgImage: croppedCGImage,
            scale: 1.0,
            orientation: imageOrientation
        )
    }

    func jpegData(
        resizeImageTo targetSize: CGSize,
        preservingAspectRatio: Bool = true,
        maxSizeInMB: Double,
        initialCompressionQuality: CGFloat
    ) -> Data? {
        let scaledImageSize: CGSize
        if preservingAspectRatio {
            // Determine the scale factor that preserves aspect ratio
            let widthRatio = targetSize.width / size.width
            let heightRatio = targetSize.height / size.height

            let scaleFactor = min(widthRatio, heightRatio)

            // Compute the new image size with scale factor
            scaledImageSize = CGSize(
                width: size.width * scaleFactor,
                height: size.height * scaleFactor
            )
        } else {
            scaledImageSize = targetSize
        }

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize, format: format)

        let maxSizeInBytes = UInt64(maxSizeInMB * 1024 * 1024)
        var compressionQuality = initialCompressionQuality
        while compressionQuality > 0.0 {
            let data = renderer.jpegData(withCompressionQuality: compressionQuality) { _ in
                self.draw(in: CGRect(
                    origin: .zero,
                    size: scaledImageSize
                ))
            }

            // Return data if size is less than the max size in bytes
            if UInt64(data.count) < maxSizeInBytes {
                return data
            }

            // Else reduce compression quality and try again
            compressionQuality -= 0.1
        }

        return nil
    }
}
