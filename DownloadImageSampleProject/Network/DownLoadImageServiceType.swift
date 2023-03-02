//
//  DownLoadImageServiceType.swift
//  DownloadImageSampleProject
//
//  Created by 주혁 on 2023/03/02.
//

import Foundation
import UIKit

protocol DownLoadImageServiceType {
    func fetchImageURLList() -> [String]
    func loadImage(imageURL: String, completion: (Int) -> Void) async throws -> UIImage?
}
