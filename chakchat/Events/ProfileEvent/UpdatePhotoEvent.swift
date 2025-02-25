//
//  UpdatePhotoEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 25.02.2025.
//

import UIKit

final class UpdatePhotoEvent: Event {
    
    let newPhoto: URL?
    
    init(newPhoto: URL?) {
        self.newPhoto = newPhoto
    }
}
