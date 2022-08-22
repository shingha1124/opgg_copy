//
//  PreviewMockData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Foundation

final class PreviewMockData {
    
    //swiftlint: disable force_unwrapping
    
    static let shard = PreviewMockData()
    
    private init() {}
    
    var detailViewModel: DetailViewModel {
        DetailViewModel("zkDo7tkDVQsxjkwzskG9-ixLhBHvxOQgB9p9ULVcO1HmtA")
    }
    
    var previousSeason: PreviousSeason {
        PreviousSeason(
            seasonID: 17,
            tierInfo: tierInfo,
            createdAt: Date())
    }
    
    var tierInfo: TierInfo {
        TierInfo(
            tier: .bronze,
            division: 1,
            lp: 50,
            tierImageURL: URL(string: "https://opgg-static.akamaized.net/images/medals_new/bronze.png")!,
            borderImageURL: URL(string: "https://opgg-static.akamaized.net/images/border_new/bronze.png")!
        )
    }
}
