//
//  WelcomeManager.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

public final class WelcomeManager {
    
    // MARK: - Properties
    private let remote: WelcomeManagerRemoteAPI
    private let alerts: WelcomeManagerAlerts
    private let usernameRequired: Bool
    private let finished: () -> Void
    
    
    // MARK: - Init
    public init(remote: WelcomeManagerRemoteAPI,
                alerts: WelcomeManagerAlerts,
                usernameRequired: Bool,
                finished: @escaping () -> Void) {
        
        self.remote = remote
        self.alerts = alerts
        self.usernameRequired = usernameRequired
        self.finished = finished
    }
}


// MARK: UIResponder
extension WelcomeManager {

    public func finishWelcome(_ name: String) {
        validateUsername(name) { [weak self] in
            self?.uploadWelcomeData(name)
        }
    }
}


// MARK: - Helper Methods
private extension WelcomeManager {
    
    func validateUsername(_ name: String, completion: @escaping () -> Void) {
        
        guard usernameRequired else { return completion() }
        
        remote.checkForDuplicates(name) { [weak self] error in
            
            if let error = error {
                self?.showError(error)
            } else {
                completion()
            }
        }
    }
    
    func uploadWelcomeData(_ name: String) {
        remote.finishWelcome(username: name) { [weak self] error in
            
            if let error = error {
                self?.showError(error)
            } else {
                self?.finished()
            }
        }
    }
    
    func showError(_ error: Error) {
        alerts.showError(error)
    }
}


// MARK: - Dependencies
public protocol WelcomeManagerAlerts {
    func showError(_ error: Error)
}

public protocol WelcomeManagerRemoteAPI {
    func checkForDuplicates(_ name: String,
                            completion: @escaping (Error?) -> Void)
    func finishWelcome(username: String?,
                       completion: @escaping (Error?) -> Void)
}
