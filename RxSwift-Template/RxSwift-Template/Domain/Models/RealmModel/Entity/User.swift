//
//  User.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import RealmSwift

class User {
    var id: String = ""
    var passWord: String?
    
    convenience init?(_ model: RUser?) {
        self.init()
        guard  let model = model else {
            return nil
        }
        self.parseFromRealm(model)
    }
    
    private func parseFromRealm(_ model: RUser) {
        self.id = model.id
        self.passWord = model.passWord
    }
    
    class func parseFromList(_ listModel: [RUser]) -> [User] {
        var list: [User] = []
        for model in listModel {
            if let newsList = User(model) {
                list.append(newsList)
            }
        }
        return list
    }
}
