//
//  RUser.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import RealmSwift
import Realm

class RUser: Object {
    @objc dynamic var id = ""
    @objc dynamic var passWord: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init?(_ model: User?) {
        self.init()
        parse(model)
    }
    
    static func factoryMethod(_ model: User?) -> RUser? {
        let this = RUser(model)
        return this
    }
    
    static func factoryMethods(_ models: [User]?) -> List<RUser>? {
        guard let models = models else { return nil }
        
        let this = List<RUser>()
        for model in models {
            if let my = RUser.factoryMethod(model) {
                this.append(my)
            }
        }
        return this
    }
    
    fileprivate func parse(_ model: User?) {
        guard let modelParse = model else {
            return
        }
        self.id = modelParse.id
        self.passWord = modelParse.passWord
    }
}
