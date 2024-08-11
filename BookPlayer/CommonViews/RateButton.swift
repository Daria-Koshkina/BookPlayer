//
//  RateButton.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 11.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct RateState: Equatable {
  var playbackRate: Float
}

enum RateAction: Equatable {
  case changePlaybackRate(Float)
}

class RateReducer: Reducer {
  typealias State = RateState
  typealias Action = RateAction
  
  func reduce(into state: inout RateState, action: RateAction) -> Effect<RateAction> {
    switch action {
    case .changePlaybackRate(let newRate):
      state.playbackRate = newRate
      return .none
    }
  }
}

struct RateButton: View {
  let store: StoreOf<RateReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Button(action: {
        viewStore.send(.changePlaybackRate(nextRate(current: viewStore.playbackRate)))
      }) {
        Text("Speed x\(String(format: "%.2f", viewStore.playbackRate))")
          .font(.system(size: 12, weight: .semibold, design: .rounded))
      }
      .frame(width: 100, height: 30)
      .background(.gray.opacity(0.2))
      .foregroundColor(.black)
      .clipShape(RoundedRectangle(cornerRadius: 12))
    }
  }
  
  private func nextRate(current: Float) -> Float {
    switch current {
    case 1.0:
      return 1.5
    case 1.5:
      return 2.0
    case 2.0:
      return 0.5
    default:
      return 1.0
    }
  }
}
