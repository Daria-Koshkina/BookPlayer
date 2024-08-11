//
//  BookPlayerReducer.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 05.08.2024.
//

import Foundation
import ComposableArchitecture

class BookPlayerReducer: Reducer {
  
  typealias State = BookPlayerState
  typealias Action = BookPlayerAction
  
  var rateReducer = RateReducer()
  
  func reduce(into state: inout BookPlayerState, action: BookPlayerAction) -> Effect<BookPlayerAction> {
    switch action {
    case .play:
      state.isPlaying = true
      AudioManager.shared.playSound(named: state.currentChapter.fileName)
      return .run { send in
        while true {
          try await Task.sleep(nanoseconds: 1_000_000_000)
          await send(.updateCurrentTime(AudioManager.shared.playbackPosition))
        }
      }
      .cancellable(id: TimerID())
      
    case .pause:
      state.isPlaying = false
      AudioManager.shared.stopSound()
      return .cancel(id: TimerID())
      
    case .togglePlayPause:
      if state.isPlaying {
        return self.reduce(into: &state, action: .pause)
      } else {
        return self.reduce(into: &state, action: .play)
      }
      
    case .seek(let time):
      state.currentTime = time
      AudioManager.shared.setCurrentPlayTime(time)
      return .none
      
    case .changePlaybackRate(let rateAction):
      let rateEffect = rateReducer.reduce(into: &state.playbackRate, action: rateAction)
      AudioManager.shared.setPlaybackRate(rate: state.playbackRate.playbackRate)
      return rateEffect.map(BookPlayerAction.changePlaybackRate)
      
    case .rewind(let seconds):
      AudioManager.shared.rewind(by: seconds)
      state.currentTime = AudioManager.shared.playbackPosition
      return .none
      
    case .fastForward(let seconds):
      AudioManager.shared.fastForward(by: seconds)
      state.currentTime = AudioManager.shared.playbackPosition
      return .none
      
    case .chapterChanged(let chapter):
      AudioManager.shared.stopSound()
      state.currentChapter = chapter
      state.currentTime = 0
      state.totalTime = TimeInterval(chapter.duration)
      return self.reduce(into: &state, action: .play)
      
    case .updateCurrentTime(let time):
      state.currentTime = time
      return .none
      
    case .setDetailViewPresented(let isPresented):
      state.isDetailViewPresented = isPresented
      return .none
      
    case .chapterSelected(let chapter):
      state.isDetailViewPresented = false
      return self.reduce(into: &state, action: .chapterChanged(chapter))
    }
  }
}

struct TimerID: Hashable {}

