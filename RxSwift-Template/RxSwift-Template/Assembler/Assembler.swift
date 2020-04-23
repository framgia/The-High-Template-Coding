//
//  Assembler.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol Assembler: class,
    MainAssembler,
    RepositoriesAssembler,
    AppAssembler {
}

final class DefaultAssembler: Assembler {
    
}
