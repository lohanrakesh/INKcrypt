//
//  ConfigrationManager.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 26/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation

final class ConfigurationManager: NSObject {
    /*
     Open your Project Build Settings and search for “Swift Compiler – Custom Flags” … “Other Swift Flags”.
     Add “-DDEVELOPMENT” to the Debug section
     Add “-DQA” to the QA section
     Add “-DSTAGING” to the Staging section
     Add “-DPRODUCTION” to the Release section
     */
    fileprivate enum AppEnvironment: String {
        case development = "Development"
        case qAss = "QA"
        case staging = "Staging"
        case production = "Production"
    }

    fileprivate struct AppConfiguration {
        var apiEndPoint: String
        var analyticsKey: String
        var environment: AppEnvironment
    }


    fileprivate var activeConfiguration: AppConfiguration!

    // MARK: - Singleton Instance

    private static let _sharedManager = ConfigurationManager()

    class func sharedManager() -> ConfigurationManager {
        return self._sharedManager
    }

    private override init() {
        super.init()

        // Load application selected environment and its configuration
        if let environment = self.currentEnvironment() {
            self.activeConfiguration = self.configuration(environment: environment)

            if self.activeConfiguration == nil {
                assertionFailure(NSLocalizedString("Unable to load application configuration", comment: "Unable to load application configuration"))
            }
        } else {
            assertionFailure(NSLocalizedString("Unable to load application flags", comment: "Unable to load application flags"))
        }
    }

    private func currentEnvironment() -> AppEnvironment? {
        #if QA
            return AppEnvironment.qA
        #elseif STAGING
            return AppEnvironment.staging
        #elseif PRODUCTION
            return AppEnvironment.production
        #else // Default configuration DEVELOPMENT
            return AppEnvironment.development
        #endif

        /* let environment = Bundle.main.infoDictionary?["ActiveConfiguration"] as? String
         return environment */
    }

    /**
     Returns application active configuration

     - parameter environment: An application selected environment

     - returns: An application configuration structure based on selected environment
     */
    private func configuration(environment: AppEnvironment) -> AppConfiguration {
        switch environment {
        case .development:
            return self.debugConfiguration()
        case .qAss:
            return self.qaConfiguration()
        case .staging:
            return self.stagingConfiguration()
        case .production:
            return self.productionConfiguration()
        }
    }
    

    
     func aESEncryptionIVKey() -> String {
         let environment = self.currentEnvironment()
        switch environment {
        case .development?:
            return "770A8A65DA156D24"
        case .qAss?:
            return "770A8A65DA156D24"
        case .staging?:
            return "770A8A65DA156D24"
        case .production?:
            return "770A8A65DA156D24"
        case .none:
            return "770A8A65DA156D24"
        }
    }
    
     func aESEncryptionSecretKey() -> String {
        let environment = self.currentEnvironment()
        switch environment {
        case .development?:
            return "770A8A65DA156D24"
        case .qAss?:
            return "770A8A65DA156D24"
        case .staging?:
            return "770A8A65DA156D24"
        case .production?:
            return "770A8A65DA156D24"
        case .none:
            return "770A8A65DA156D24"
        }
    }


    private func debugConfiguration() -> AppConfiguration {
        let appConfigration  = AppConfiguration(apiEndPoint: "http://193.168.0.46:96", analyticsKey: "", environment: .development)

        debugPrint("Server on \(appConfigration.environment) and URl is \(appConfigration.apiEndPoint)")
        return appConfigration
    }

    // MARK: Please change the key values
    private func qaConfiguration() -> AppConfiguration {
        let appConfigration = AppConfiguration(apiEndPoint: "", analyticsKey: "", environment: .qAss)
        debugPrint("Server on \(appConfigration.environment) and URl is \(appConfigration.apiEndPoint)")
        return appConfigration
    }

    // MARK: Please change the key values
    private func stagingConfiguration() -> AppConfiguration {
        let appConfigration = AppConfiguration(apiEndPoint: "", analyticsKey: "", environment: .staging)
        debugPrint("Server on \(appConfigration.environment) and URl is \(appConfigration.apiEndPoint)")
        return appConfigration
    }

    // MARK: Please change the key values
    private func productionConfiguration() -> AppConfiguration {
        let appConfigration = AppConfiguration(apiEndPoint: "", analyticsKey: "", environment: .production)
        debugPrint("Server on \(appConfigration.environment) and URl is \(appConfigration.apiEndPoint)")
        return appConfigration
    }
}

extension ConfigurationManager {

    // MARK: - Public Methods

    func applicationEnvironment() -> String {
        return self.activeConfiguration.environment.rawValue
    }

    func applicationEndPoint() -> String {
        return self.activeConfiguration.apiEndPoint
    }

    func analyticsKey() -> String {
        return self.activeConfiguration.analyticsKey
    }
}
