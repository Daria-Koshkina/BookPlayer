//
//  BookPlayerAction.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 05.08.2024.
//

import Foundation

enum BookPlayerAction: Equatable {
  case play
  case pause
  case togglePlayPause
  case seek(TimeInterval)
  case changePlaybackRate(RateAction)
  case rewind(TimeInterval)
  case fastForward(TimeInterval)
  case chapterChanged(Chapter)
  case updateCurrentTime(TimeInterval)
  case setDetailViewPresented(Bool)
  case chapterSelected(Chapter)
}
