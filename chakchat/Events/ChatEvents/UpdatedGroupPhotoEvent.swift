//
//  UpdatedGroupPhotoEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.03.2025.
//

import UIKit

final class UpdatedGroupPhotoEvent: Event {
    let photo: UIImage?
    
    init(photo: UIImage?) {
        self.photo = photo
    }
}
