//
//  ImageStore.swift
//  Recipes
//
//  Created by David Wright on 3/18/25.
//

import UIKit

protocol ImageStoreProtocol {
    func getImage(for url: URL) -> UIImage?
    func setImage(_ image: UIImage, for url: URL)
}
