//
//  RemoteAuthentication.swift
//  Data
//
//  Created by André Haas on 04/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAuthentication {

    private let url: URL
    private let httpClient: HttpPostClient

    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }

    public func auth(authenticationModel: AuthenticationModel){
        httpClient.post(to: url, with: authenticationModel.toData()){_ in }
    }
    
    //    func auth(authenticationModel: AuthenticationModel, completion: @escaping (AddAccount.Result) -> Void) {
    //        httpClient.post(to: url, with: authenticationModel.toData()) { [weak self] result in
    //            guard self != nil else { return }
    //            switch result {
    //            case .success(let data):
    //                if let model: AccountModel = data?.toModel() {
    //                    completion(.success(model))
    //                }else{
    //                    completion(.failure(.unexpected))
    //                }
    //            case .failure(let error):
    //                switch error {
    //                case .forbidden:
    //                    completion(.failure(.emailInUse))
    //                default:
    //                    completion(.failure(.unexpected))
    //                }
    //
    //            }
    //
    //        }
    //    }

}
