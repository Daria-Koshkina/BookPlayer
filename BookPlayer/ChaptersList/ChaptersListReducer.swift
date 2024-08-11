//
//  ChaptersListReducer.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 09.08.2024.
//

import Foundation
import ComposableArchitecture

class ChaptersListReducer: Reducer {
  typealias State = ChaptersListState
  
  typealias Action = ChaptersListAction
  
  func reduce(into state: inout ChaptersListState, action: ChaptersListAction) -> Effect<ChaptersListAction> {
    switch action {
    case .displayChapters(let chapters):
      state.chapters = chapters
      return .none
    }
  }
}
