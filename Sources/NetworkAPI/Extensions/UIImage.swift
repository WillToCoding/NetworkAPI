//
//  UIImage.swift
//  EmpleadosAPI
//
//  Created by Juan Carlos on 24/11/25.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit

public extension UIImage {
    func resize(width: CGFloat) async -> UIImage? {
        let scale = min(1, width / size.width)
        let newSize = CGSize(width: width, height: size.height * scale)

        #if os(iOS) || os(visionOS)
        return await byPreparingThumbnail(ofSize: newSize)
        #elseif os(tvOS)
        // tvOS: UIGraphicsImageRenderer
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        #else
        // watchOS: no resize, devolver original
        return self
        #endif
    }
}
#elseif os(macOS)
import AppKit

public extension NSImage {
    func resize(width: CGFloat) async -> NSImage? {
        let scale = min(1, width / size.width)
        let newSize = CGSize(width: width, height: size.height * scale)

        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let context = CGContext(
            data: nil,
            width: Int(newSize.width),
            height: Int(newSize.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )

        context?.interpolationQuality = .high
        context?.draw(cgImage, in: CGRect(origin: .zero, size: newSize))

        guard let resizedCGImage = context?.makeImage() else { return nil }
        return NSImage(cgImage: resizedCGImage, size: newSize)
    }
}
#endif

// MARK: - (iOS only)
//
// #if os(iOS)
// import UIKit
//
// extension UIImage {
//     func resize(width: CGFloat) async -> UIImage? {
//         let scale = min(1, width / size.width)
//         let size = CGSize(width: width, height: size.height * scale)
//         return await byPreparingThumbnail(ofSize: size)
//     }
// }
// #endif


