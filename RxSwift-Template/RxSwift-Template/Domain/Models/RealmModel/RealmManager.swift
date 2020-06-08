//
//  RealmManager.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import FileProvider

enum WriteQueryType {
    case add
    case update
    case delete
    case deleteAll
}

class RealmManager {
    // MARK: - Config
    static func configDefault() {
        let fileURL = Realm.Configuration.defaultConfiguration.fileURL
        print("\(String(describing: fileURL))")
        
        // get schema version
        let schemaVersion = GlobalConfig.dataVersion
        
        // create config
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < schemaVersion {
                    // MARK: - Migration (Change key)
//                    migration.enumerateObjects(ofType: Person.className()) { oldObject, newObject in
//                    // combine name fields into a single field
//                    let firstName = oldObject!["firstName"] as! String
//                    let lastName = oldObject!["lastName"] as! String
//                    newObject!["fullName"] = "\(firstName) \(lastName)"
                }
        })
        
        // set config
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - GetRealmDataFromFile
    static func getRealmDB(dbName: String, isReadOnly: Bool = false) -> Realm? {
        var reamDB: Realm?
        let schemaVersion = GlobalConfig.dataVersion
        var fileURL = Bundle.main.url(forResource: dbName, withExtension: "realm")
        
        if isReadOnly == false {
            self.copyBundleFile(dbName: dbName)
        }
        
        fileURL = self.loadRealmFromDocumentDirectory(dbName: dbName)
        guard let urlDB = fileURL else {
            return nil
        }
        
        let config = Realm.Configuration(fileURL: urlDB,
                                         readOnly: isReadOnly,
                                         schemaVersion: schemaVersion,
                                         migrationBlock: { (_, oldSchemaVer) in
                                            if oldSchemaVer < schemaVersion {
                                                // MARK: - Migration (Change key)
//                                                 migration.enumerateObjects(ofType: Person.className()) { oldObject, newObject in
//                                                 combine name fields into a single field
//                                                 let firstName = oldObject!["firstName"] as! String
//                                                 let lastName = oldObject!["lastName"] as! String
//                                                 newObject!["fullName"] = "\(firstName) \(lastName)"
                                            }
        })
        
        do {
            let realm = try Realm(configuration: config)
            reamDB = realm
        } catch let error as NSError {
            print("error config realm", error.localizedDescription)
            reamDB = nil
        }
        
        return reamDB
    }
    
    // MARK: - Get object with predicate
    static func objects<Element: Object>(_ type: Element.Type, predicate: NSPredicate? = nil) -> [Element]? {
        let objectName = String(describing: type)
        let realm = RealmManager.getRealmDB(dbName: objectName)
        
        guard let realmObject = realm else {
            return nil
        }
        
        var resultObject = realmObject.objects(type)
        if let predicateFilter = predicate {
            resultObject = resultObject.filter(predicateFilter)
        }
        return resultObject.toArray(type: type)
    }
    
    static func query(realmDB: Realm?, object: Object?,
                          typeQuery: WriteQueryType,
                          completion: @escaping (Bool, NSError?) -> Void) {
        guard let realm = realmDB, let objectQuery = object else {
            completion(false, nil)
            return
        }
        
        do {
            realm.beginWrite()
            switch typeQuery {
            case .add:
                realm.add(objectQuery, update: .error)
            case .update:
                realm.add(objectQuery, update: .modified)
            case .delete:
                realm.delete(objectQuery)
            case .deleteAll:
                realm.deleteAll()
            }
            try realm.commitWrite()
            completion(true, nil)
        } catch let error as NSError {
            completion(false, error)
        }
    }
}

extension Results {
    // MARK: - Convert to array
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

extension RealmManager {
    // MARK: - Coppy file to Document
    static func copyBundleFile(dbName: String) {
        let pathURL = self.documentsSubdirectory(dbName: dbName)
        if let fileDB = Bundle.main.url(forResource: dbName, withExtension: ".realm"),
            let url = pathURL {
            do {
                if FileManager.default.fileExists(atPath: url.path) {
                    try FileManager.default.removeItem(atPath: url.path)
                }
                try FileManager.default.copyItem(at: fileDB, to: url)
                self.addSkipBackupAttributeToItem(at: url) // excluding file from backup
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static func documentsSubdirectory(dbName: String) -> URL? {
        let  paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dataPath = paths[0] // Get documents folder
        let url = URL(fileURLWithPath: dataPath).appendingPathComponent(dbName + ".realm")
        return url
    }
    
    @discardableResult
    static func addSkipBackupAttributeToItem(at URL: URL?) -> Bool {
        var success = false
    
        do {
            try (URL as NSURL?)?.setResourceValue(NSNumber(value: true), forKey: .isExcludedFromBackupKey)
            success = true
        } catch let error {
            Logger.debug("Error excluding \(URL?.lastPathComponent ?? "") from backup \(error)")
        }

        return success
    }
    
    static func loadRealmFromDocumentDirectory(dbName: String) -> URL? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        var dbURL: URL?
        if let dirPath = paths.first {
            dbURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(dbName).realm")
        }
        return dbURL
    }
}
