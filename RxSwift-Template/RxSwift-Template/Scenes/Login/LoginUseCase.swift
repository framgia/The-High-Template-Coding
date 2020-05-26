//
//  LoginUseCase.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol LoginUseCaseType {
    func saveAccount(id: String?, passWord: String?) -> Observable<Void>
}

struct LoginUseCase: LoginUseCaseType {
    let repoRepo: RepoRepositoryType
    
    func saveAccount(id: String?, passWord: String?) -> Observable<Void> {
        return Observable.create { obser -> Disposable in
            
            guard let id = id, let passWord = passWord else {
                obser.onError(LoginError.empty)
                return Disposables.create()
            }

            if id.count == 0 || passWord.count == 0 {
                obser.onError(LoginError.empty)
                return Disposables.create()
            }

            let user = User()
            user.id = id
            user.passWord = passWord
            
            RealmManager.query(
                realmDB: RealmManager.getRealmDB(dbName: DataName.user, isReadOnly: false),
                object: RUser(user),
                typeQuery: .update) { _, _ in }
            
            obser.onNext(())
            obser.onCompleted()
            return Disposables.create()
        }
    }
}
