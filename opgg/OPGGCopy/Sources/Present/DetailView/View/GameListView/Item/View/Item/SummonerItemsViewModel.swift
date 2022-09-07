//
//  SummonerItemsView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Combine
import Foundation

final class SummonerItemsViewModel: ObservableObject {
    
    class ItemModel {
        let index: Int
        private(set) var item: ItemDatum?
        
        init(_ index: Int, item: ItemDatum?) {
            self.index = index
            self.item = item
        }
    }
    
    struct State {
        var items = [ItemModel]()
        var trinketItem: ItemDatum?
    }
    
    struct Update {
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    @Inject(\.itemData) private var itemData: ItemData
        
    init(_ items: [Int], trinketItem: Int) {
        state.items = items.enumerated().map { index, id in
            ItemModel(index, item: itemData[id])
        }
        
        state.trinketItem = itemData[trinketItem]
    }
}
 
