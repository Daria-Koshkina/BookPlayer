//
//  PlayerSliderView.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 11.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct PlayerSliderView: View {
  let store: StoreOf<BookPlayerReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      HStack(alignment: .center, spacing: 5) {
        Text(viewStore.currentTime.formattedTime)
          .font(.system(size: 10, weight: .regular, design: .default))
          .foregroundColor(.secondary)
          .frame(width: 30)
        Slider(value: viewStore.binding(
          get: \.currentTime,
          send: BookPlayerAction.seek
        ), in: 0...viewStore.totalTime)
        Text(viewStore.totalTime.formattedTime)
          .font(.system(size: 10, weight: .regular, design: .default))
          .foregroundColor(.secondary)
          .frame(width: 30)
      }
      .frame(maxHeight: 4)
      .padding()
    }
  }
}
