//
//  UIImageView+Ext.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

extension UIImageView {
    func downloadImageForCash(fromUrl url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async { self.image = image }
        }
    }
}
