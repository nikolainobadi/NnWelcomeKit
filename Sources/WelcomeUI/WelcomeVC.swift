//
//  WelcomeVCWelcomeVC.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

import UIKit
import NnUIKitHelpers

public final class WelcomeVC: NnViewController {
    
    // MARK: - Properties
    private let rootView: UIView
    private let isPresentedModally: Bool
    
    
    // MARK: - Init
    public init(rootView: UIView,
                isPresentedModally: Bool,
                fieldsToObserver: [UITextField]) {
        
        self.rootView = rootView
        self.isPresentedModally = isPresentedModally
        super.init(hasTextFields: true, fieldsToObserve: fieldsToObserver)
    }
    
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = isPresentedModally
    }
    
    public override func loadView() {
        view = rootView
    }
}
