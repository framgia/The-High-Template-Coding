//
//  Repo.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//


struct Repo: Codable {
    var id: Int
    var name: String
    var fullname: String
    var urlString: String
    var starCount: Int
    var folkCount: Int
    var owner: Owner
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullname = "full_name"
        case urlString = "url"
        case starCount = "stargazers_count"
        case folkCount = "forks_count"
        case owner = "owner"
    }
}

struct Owner: Codable {
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}

extension Repo: Then { }
