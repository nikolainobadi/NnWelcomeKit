//
//  WelcomeRootView.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

import UIKit
import NnUIKitHelpers

public final class WelcomeRootView: NnView {
    
    // MARK: - Properties
    private let config: WelcomeViewInfo
    private let finished: () -> Void
    
    
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        UILabel(config.titleText)
            .autoSize()
            .addShadow()
            .setAlignment(.center)
            .setColor(config.titleColor)
            .setFontByStyle(.largeTitle)
    }()
    
    
    lazy var detailsLabel: UILabel = {
        UILabel()
            .multipleLines()
            .setAlignment(.center)
            .setFontByStyle(.detail, fontName: .thonburi)
    }()
    
    lazy var usernameField: ShadowField = {
        ShadowField("enter username...", withErrorLabel: true)
    }()
    
    lazy var toolBar: TextFieldToolBar = {
        makeToolBar()
    }()
    
    lazy var okayButton: UIButton = {
        ShadowButton(config.buttonText)
            .setColor(config.buttonTextColor,
                      backgroundColor: config.buttonColor)
            .setAction { [weak self] in
                self?.finished()
            }
    }()
    
    
    // MARK: - Init
    public init(config: WelcomeViewInfo, finished: @escaping () -> Void) {
        self.config = config
        self.finished = finished
        super.init(frame: .zero, color: config.backgroundColor)
        
        configureView()
    }
    
    
    // MARK: - Display Setup
    public override func addSubviews() {
        addSubview(titleLabel)
        addSubview(detailsLabel)
        addSubview(usernameField)
        addSubview(okayButton)
    }
    
    public override func setupConstraints() {
        titleLabel.anchor(safeTopAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          topConstant: heightPercent(1),
                          leftConstant: widthPercent(2),
                          rightConstant: widthPercent(2))

        detailsLabel.anchor(titleLabel.bottomAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            topConstant: heightPercent(5),
                            leftConstant: widthPercent(2),
                            rightConstant: widthPercent(2))

        usernameField.anchorCenterXToSuperview()
        usernameField.anchor(detailsLabel.bottomAnchor,
                             topConstant: heightPercent(10),
                             widthConstant: widthPercent(70),
                             heightConstant: buttonHeight)

        okayButton.anchorCenterXToSuperview()
        okayButton.anchor(usernameField.bottomAnchor,
                          topConstant: heightPercent(4),
                          widthConstant: widthPercent(70))
    }
}


// MARK: - Helper Methods
private extension WelcomeRootView {
    
    func configureView() {
        detailsLabel.text = config.details
        usernameField.alpha = config.showField ? 1 : 0
        usernameField.inputAccessoryView = toolBar
    }
    
    func makeToolBar() -> TextFieldToolBar {
        TextFieldToolBar { [weak self] in
            self?.finished()
        } onCancelTapped: { [weak self] in
            self?.endEditing(true)
        }
    }
}

