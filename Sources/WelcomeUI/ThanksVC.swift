//
//  ThanksVC.swift
//  
//
//  Created by Nikolai Nobadi on 2/16/22.
//

import UIKit
import NnUIKitHelpers

public final class ThanksVC: NnViewController {
    
    // MARK: - Properties
    private let config: ThanksViewConfig
    
    
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        UILabel(config.titleText)
            .autoSize()
            .addShadow()
            .setAlignment(.center)
            .setColor(config.titleColor)
            .setFontByStyle(.largeTitle)
    }()
    
    
    // MARK: - Init
    public init(config: ThanksViewConfig) {
        self.config = config
        super.init(hasTextFields: false)
        
        view.backgroundColor = config.backgroundColor
    }
    
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        titleLabel.anchor(view.safeTopAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                          topConstant: view.heightPercent(1),
                          leftConstant: view.widthPercent(2),
                          rightConstant: view.widthPercent(2))
    }
}


// MARK: - Dependencies
public struct ThanksViewConfig {
    public var titleText: String
    public var titleColor: UIColor?
    public var backgroundColor: UIColor?
    
    public init(titleText: String = "Thank You",
                titleColor: UIColor? = .label,
                backgroundColor: UIColor? = .systemBackground) {
        
        self.titleText = titleText
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
}
