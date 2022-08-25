//
//  Container.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Foundation

class Container {
    static var shared = Container()
    
    private init() { }
    
    let opggRepository: OpggRepository = OpggRepositoryImpl()
    let seasonData = SeasonData()
    let tierImageData = TierImageData()
}
