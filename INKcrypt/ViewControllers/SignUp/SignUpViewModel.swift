//
//  SignUpViewModel.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 02/09/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import RealmSwift

class SignUpViewModel{
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobileNumberCode: String?
    var mobileNumber: String?
    var password: String?
    var rePassword: String?
    var countryCodeArray = [CountryCode]()
    typealias apiResponseCompletion = ((_ success:Bool, _ message:String?) -> Void)
    let router = Router.sharedInstance
    
    //MARK:- API
    func getCountryCodeApiCall(completion:@escaping apiResponseCompletion ){
        self.router.serviceForEndPoint(apiType: .countryCode, decodingType: [CountryCode].self) { [weak self] result in
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {return}
                if  response.success {
                    if let objects = model {
                        self?.countryCodeArray.removeAll()
                        for object in objects {
                            self?.countryCodeArray.append(object)
                        }
                    }
                    completion(true, nil)
                } else {
                   completion(false, AlertMessages.error.rawValue)
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func signUpApiCall(completion:@escaping apiResponseCompletion ){
        if let firstName = self.firstName, let email = self.email, let password = self.password?.aesEncrypt(), let mobile = self.mobileNumber, let code = self.mobileNumberCode {
            let parameter = ["FisrtName": firstName, "LastName": self.lastName ?? "", "EMail": email, "MobileNo": mobile, "Password": password, "UniqueDeviceID": UIDevice.current.identifierForVendor!.uuidString, "CountryCode": code, "DeviceTypeId": Constants.DeviceType.deviceTypeId]
            router.serviceForEndPoint(apiType: .signUp(dict: parameter), decodingType: LoginDetails.self) { (result) in
                switch result {
                case .success(let responseData, let model):
                    guard let response = responseData else {return}
                    if  response.success {
                        if let login = model {
                            
                            DispatchQueue.main.async {
                                let realm: Realm!
                                do {
                                    realm = try Realm()
                                    try? realm.write {
                                        let user = realm.objects(LoginDetails.self)
                                        realm.delete(user)
                                        realm.add(login, update: true)
                                    }
                                }catch {
                                    completion(false, AlertMessages.error.rawValue)
                                    debugPrint("Realm istance not created")
                                }
                            }
                        }
                    } else {
                       completion(false, AlertMessages.error.rawValue)
                    }
                    
                case .failure(let error):
                   completion(false, error.localizedDescription)
                }
            }
        }else {
            completion(false, AlertMessages.error.rawValue)
        }
    }
    
    
}
