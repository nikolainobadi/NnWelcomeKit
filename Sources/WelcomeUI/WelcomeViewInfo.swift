//
//  WelcomeViewModel.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

import UIKit

public protocol WelcomeViewInfo {
    var details: String { get }
    var showField: Bool { get }
    var titleText: String { get }
    var titleColor: UIColor? { get }
    var buttonText: String { get }
    var buttonTextColor: UIColor? { get }
    var buttonColor: UIColor? { get }
    var backgroundColor: UIColor? { get }
}
