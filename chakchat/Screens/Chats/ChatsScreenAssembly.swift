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
        var presenter = ChatsScreenPresenter()
        var worker = ChatsScreenWorker()
        var interactor = ChatsScreenInteractor(presenter: presenter, worker: worker)
        var view = ChatsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
