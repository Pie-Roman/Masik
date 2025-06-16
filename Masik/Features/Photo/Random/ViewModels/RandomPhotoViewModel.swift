//
//  RandomPhotoViewModel.swift
//  Masik
//
//  Created by Роман Ломтев on 12.06.2025.
//

import Photos
import UIKit

class RandomPhotoViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []

    init() {
        requestAuthorizationAndFetchRandom()
    }

    func requestAuthorizationAndFetchRandom() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized || status == .limited {
                self.fetchRandom()
            }
        }
    }

    private func fetchRandom() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let imageManager = PHImageManager.default()

        let sampleCount = min(20, fetchResult.count)
        let randomIndexes = (0..<fetchResult.count).shuffled().prefix(sampleCount)

        let screenScale = UIScreen.main.scale
        let previewHeight: CGFloat = 160 // такая же, как frame высота в RandomPreview
        let targetSize = CGSize(width: previewHeight * screenScale, height: previewHeight * screenScale)

        for index in randomIndexes {
            let asset = fetchResult.object(at: index)
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.isSynchronous = false

            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, _ in
                if let image = image {
                    DispatchQueue.main.async {
                        self.images.append(image)
                    }
                }
            }
        }
    }
}
