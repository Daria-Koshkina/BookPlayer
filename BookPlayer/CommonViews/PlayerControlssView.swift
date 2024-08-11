//
//  PlayerButtonsViews.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 11.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct PlayerControlssView: View {
  
  let store: StoreOf<BookPlayerReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      HStack {
        Button(action: {
          guard viewStore.currentChapter.chapterNumber > 1 else { return }
          viewStore.send(.chapterChanged(viewStore.book.chapters[viewStore.currentChapter.chapterNumber - 2]))
        }) {
          Image(systemName: "backward.fill")
            .font(.system(size: 24))
            .foregroundColor(.black)
            .padding()
        }
        Button(action: {
          viewStore.send(.rewind(5))
        }) {
          Image(systemName: "gobackward.5")
            .font(.system(size: 24))
            .foregroundColor(.black)
            .padding()
        }
        Button(action: {
          viewStore.send(.togglePlayPause)
        }) {
          Image(systemName: viewStore.isPlaying ? "pause.fill" : "play.fill")
            .font(.system(size: 24))
            .foregroundColor(.black)
            .padding()
        }
        Button(action: {
          viewStore.send(.fastForward(10))
        }) {
          Image(systemName: "goforward.10")
            .font(.system(size: 24))
            .foregroundColor(.black)
            .padding()
        }
        Button(action: {
          guard viewStore.currentChapter.chapterNumber < viewStore.book.chapters.count else { return }
          viewStore.send(.chapterChanged(viewStore.book.chapters[viewStore.currentChapter.chapterNumber]))
        }) {
          Image(systemName: "forward.fill")
            .font(.system(size: 24))
            .foregroundColor(.black)
            .padding()
        }
      }
    }
  }
}
