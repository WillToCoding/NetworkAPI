//
//  UIImage.swift
//  EmpleadosAPI
//
//  Created by Juan Carlos on 24/11/25.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit

extension UIImage {
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


