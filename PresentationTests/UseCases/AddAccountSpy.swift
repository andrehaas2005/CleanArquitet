//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

class AddAccountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((Result<AccountModel, DomainError>)-> Void)?
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }

    func completeWithError(_ error: DomainError){
        completion?(.failure(error))
    }

    func completeWithAccount(_ account: AccountModel){
        completion?(.success(account))
    }

}
