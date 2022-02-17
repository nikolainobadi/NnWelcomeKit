//
//  WelcomeKitComposite.swift
//  
//
//  Created by Nikolai Nobadi on 2/16/22.
//

import UIKit
import WelcomeUI
import WelcomeLogic

public final class WelcomeKitComposite {
    private init() { }
    
    public static func makeThanksVC(config: ThanksViewConfig) -> UIViewController {
        
        ThanksVC(config: config)
    }
    
    public static func makeWelcomeVC(config: WelcomeViewInfo,
                                     remote: WelcomeManagerRemoteAPI,
                                     alerts: WelcomeManagerAlerts,
                                     usernameRequired: Bool,
                                     presentModally: Bool,
                                     finished: @escaping () -> Void) -> UIViewController {
        
        let manager = WelcomeManager(remote: remote,
                                     alerts: alerts,
                                     usernameRequired: usernameRequired,
                                     finished: finished)
        
        let rootView = WelcomeRootView(config: config,
                                       finished: manager.finishWelcome(_:))
        
        return WelcomeVC(rootView: rootView,
                         isPresentedModally: presentModally,
                         fieldsToObserver: [rootView.usernameField])
    }
}
