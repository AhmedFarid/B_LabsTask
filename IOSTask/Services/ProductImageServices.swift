//
//  ProductImageServices.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import SwiftUI
import Combine

class ProductImageServices {

    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let url: URL
    private let fileManager = LocalFileManger.instance
    private let folderName = "product_images"
    private let imageName: String

    init(url: URL) {
        self.url = url
        self.imageName = url.absoluteString
        getProductImage()
    }

    private func getProductImage() {
        if let savedImage = fileManager.getImage(imageName: imageName , folderName: folderName) {
            image = savedImage
            print("Retrieved image form File Manger!")
        } else {
            downloadProductImage()
            print("Downloading image now")
        }
    }

    private func downloadProductImage() {
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self else {return}
                guard let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}

