//
//  ChaptersListView.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 09.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct ChaptersListView: View {
  
  let store: StoreOf<ChaptersListReducer>
  let onChapterSelected: (Chapter) -> Void
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.chapters, id: \.chapterNumber) { chapter in
          Button(action: {
            onChapterSelected(chapter)
          }) {
            Text(chapter.name)
              .padding()
          }
        }
      }
    }
  }
}
