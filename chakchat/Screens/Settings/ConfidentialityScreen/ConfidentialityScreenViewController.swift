//
//  ConfidentialityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit
final class ConfidentialityScreenViewController: UIViewController {
    
    let interactor: ConfidentialityScreenBusinessLogic
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(interactor: ConfidentialityScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
