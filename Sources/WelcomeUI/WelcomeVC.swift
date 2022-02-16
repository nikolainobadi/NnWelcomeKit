//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

//
//  WelcomeVC.swift
//  iGetGroceries
//
//  Created by Nikolai Nobadi on 2/15/22.
//  Copyright © 2022 Nikolai Nobadi. All rights reserved.
//

import UIKit
import NnUIKitHelpers

final class WelcomeVC: NnViewController {
    
    // MARK: - Properties
    private let rootView: UIView
    private let isPresentedModally: Bool
    
    
    // MARK: - Init
    init(rootView: UIView,
         isPresentedModally: Bool,
         fieldsToObserver: [UITextField]) {
        
        self.rootView = rootView
        self.isPresentedModally = isPresentedModally
        super.init(hasTextFields: true, fieldsToObserve: fieldsToObserver)
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = isPresentedModally
    }
    
    override func loadView() {
        view = rootView
    }
}
