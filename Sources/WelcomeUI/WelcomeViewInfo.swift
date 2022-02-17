//
//  WelcomeViewModel.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

import UIKit

public struct WelcomeViewInfo {
    public var details: String
    public var showField: Bool
    public var titleText: String
    public var titleColor: UIColor?
    public var buttonText: String
    public var buttonTextColor: UIColor?
    public var buttonColor: UIColor?
    public var backgroundColor: UIColor?
    
    public init(details: String = "",
                showField: Bool = true,
                titleText: String = "Welcome",
                titleColor: UIColor? = .label,
                buttonText: String = "Okay",
                buttonTextColor: UIColor? = .systemBackground,
                buttonColor: UIColor? = .label,
                backgroundColor: UIColor? = .systemBackground) {
        
        self.details = details
        self.showField = showField
        self.titleText = titleText
        self.titleColor = titleColor
        self.buttonText = buttonText
        self.buttonTextColor = buttonTextColor
        self.buttonColor = buttonColor
        self.backgroundColor = backgroundColor
    }
}
