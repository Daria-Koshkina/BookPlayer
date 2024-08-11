//
//  ContentView.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 05.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookPlayerView: View {
  
  let store: StoreOf<BookPlayerReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        VStack {
          Image(viewStore.book.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
          
          Text("KEY POINT \(viewStore.currentChapter.chapterNumber) OF \(viewStore.book.chapters.count)")
            .font(.system(size: 12, weight: .medium, design: .default))
            .foregroundColor(.gray)
            .padding(5)
          
          Text(viewStore.book.name + "\n" + viewStore.currentChapter.name)
            .font(.system(size: 14, weight: .regular, design: .default))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
          
          PlayerSliderView(store: store)
          
          VStack(spacing: 30) {
            RateButton(store: store.scope(
              state: \.playbackRate,
              action: { .changePlaybackRate($0) })
            )
            
            PlayerControlssView(store: store)
            
            Toggle(isOn: viewStore.binding(
              get: \.isDetailViewPresented,
              send: BookPlayerAction.setDetailViewPresented
            )) {
              Text("")
            }
            .toggleStyle(CustomToggleStyle(width: 40, height: 40))
            .frame(width: 120, height: 46)
            .sheet(isPresented: viewStore.binding(
              get: \.isDetailViewPresented,
              send: BookPlayerAction.setDetailViewPresented
            )) {
              ChaptersListView(
                store: Store(
                  initialState: ChaptersListState(chapters: viewStore.book.chapters),
                  reducer: { ChaptersListReducer() }
                ),
                onChapterSelected: { chapter in
                  viewStore.send(.chapterSelected(chapter))  
                }
              )
            }
          }
        }
      }
    }
  }
}

extension TimeInterval {
  var formattedTime: String {
    let minutes = Int(self) / 60
    let seconds = Int(self) % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }
}
