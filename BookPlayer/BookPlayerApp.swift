//
//  BookPlayerApp.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 05.08.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct BookPlayerApp: App {
  private static let store = Store(initialState: BookPlayerState(), reducer: { BookPlayerReducer() })
  
  var body: some Scene {
    WindowGroup {
      BookPlayerView(store: BookPlayerApp.store)
        .preferredColorScheme(.light)
    }
  }
}
