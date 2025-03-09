//
//  GroupProfileEditViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

final class GroupProfileEditViewController: UIViewController {
    let interactor: GroupProfileEditBusinessLogic
    
    init(interactor: GroupProfileEditBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
    }
}
