//
//  ChatsScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit
enum ChatsAssembly {
    static func build() -> UIViewController {
        let presenter = ChatsScreenPresenter()
        let worker = ChatsScreenWorker()
        let interactor = ChatsScreenInteractor(presenter: presenter, worker: worker)
        let view = ChatsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
