//
//  DownloadImageService.swift
//  DownloadImageSampleProject
//
//  Created by 주혁 on 2023/03/02.
//

import Foundation
import UIKit

class DownloadImageService: NSObject, DownLoadImageServiceType {

    let urlSesssion: URLSession = URLSession.shared
    private var progressObserver: NSKeyValueObservation?

    deinit {
        progressObserver?.invalidate()
    }

    func fetchImageURLList() -> [String] {
        return [
            "https://images.pexels.com/photos/378570/pexels-photo-378570.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            "https://images.pexels.com/photos/460672/pexels-photo-460672.jpeg",
            "https://images.pexels.com/photos/1388069/pexels-photo-1388069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            "https://images.pexels.com/photos/672532/pexels-photo-672532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            "https://images.pexels.com/photos/372490/pexels-photo-372490.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            "https://images.pexels.com/photos/5634771/pexels-photo-5634771.jpeg?auto=compress&cs=tinysrgb&w=1200"
        ]
    }

    func loadImage(imageURL: String, completion: (Int) -> Void) async throws -> UIImage? {

        guard
            let imageURL = URL(string: imageURL)
        else { return nil }
        let (imageData, _) = try await urlSesssion.data(from: imageURL)


        return UIImage(data: imageData)
    }
}
