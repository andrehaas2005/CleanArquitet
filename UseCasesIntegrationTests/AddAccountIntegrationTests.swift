//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by André Haas on 30/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class UseCasesIntegrationTests: XCTestCase {
    //Testando a api que foi criada por nós

    func test_Add_Account() {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Andre Haas",
                                              email: "\(UUID().uuidString)@gmail.com",
                                              password: "123qazxsw",
                                              passwordConfirmation: "123qazxsw")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { (result) in
            switch result {
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            case .failure(let error):
                XCTFail("Expect success got \(error.localizedDescription) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)

        let exp2 = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { (result) in
            switch result {
            case .success:
                XCTFail("Expect success got \(result) instead")
            case .failure(let error):
                XCTAssertEqual(error, DomainError.emailInUse)
            }
            exp2.fulfill()
        }
        wait(for: [exp2], timeout: 20)
    }

    func test_Add_Account_failure() {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Andre Haas",
                                              email: "andrehaas2005@gmail.com",
                                              password: "123qazxsw",
                                              passwordConfirmation: "123qazxsw2")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { (result) in
            switch result {
            case .success:
                XCTFail("Expect success got \(result) instead")
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
    }
}
