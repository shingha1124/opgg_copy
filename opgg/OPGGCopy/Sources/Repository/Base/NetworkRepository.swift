//
//  NetworkRepository.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Foundation

class NetworkRepository<Target: BaseTarget> {
    let provider = Provider<Target>()
}
