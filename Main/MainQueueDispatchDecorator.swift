//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
private let instance: T
   public init(_ instance: T) {
        self.instance = instance
    }

    func dispatch(completion: @escaping ()->Void){
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()

    }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        instance.add(addAccountModel: addAccountModel){[weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }

}
