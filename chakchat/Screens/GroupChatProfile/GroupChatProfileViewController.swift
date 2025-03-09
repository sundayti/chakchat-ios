//
//  GroupChatProfileViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

final class GroupChatProfileViewController: UIViewController {
    let interactor: GroupChatProfileBusinessLogic
    
    init(interactor: GroupChatProfileBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        configureUI()
    }
    
    private func configureUI() {
        
    }
}
