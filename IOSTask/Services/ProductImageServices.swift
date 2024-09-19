//
//  ProductImageServices.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import SwiftUI
import Combine

protocol ProductImageServicesProtocol {
    func downloadProductImage()
}

class ProductImageServices {

    @Published var image: UIImage? = nil
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let url: String

    private let fileManager = LocalFileManger.instance
    private let folderName = "product_images"
    private let imageName: String

    init(url: String) {
        self.url = url
        self.imageName = url
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
        guard let url = URL(string: url) else {
            self.errorMessage = NetworkingError.invalidURL.localizedDescription
            return
        }

        NetworkingManger.fetchImages(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (returnedImage) in
                guard let self = self else {return}
                guard let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
            .store(in: &cancellables)
    }
}
