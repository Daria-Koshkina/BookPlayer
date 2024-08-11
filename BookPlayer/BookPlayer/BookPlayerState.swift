//
//  BookPlayerState.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 05.08.2024.
//

import Foundation

struct BookPlayerState: Equatable {
  
  // MARK: - Variables
  var book: Book
  var currentChapter: Chapter
  var isPlaying: Bool
  var playbackRate: RateState
  var currentTime: TimeInterval
  var totalTime: TimeInterval
  var isDetailViewPresented: Bool = false
  
  // MARK: - life cycle
  init(book: Book, chapter: Chapter, isPlaying: Bool = false, playbackRate: Float = 1.0, currentTime: TimeInterval = 0.0) {
    self.book = book
    self.currentChapter = chapter
    self.isPlaying = isPlaying
    self.playbackRate = RateState(playbackRate: playbackRate)
    self.currentTime = currentTime
    self.totalTime = TimeInterval(chapter.duration)
  }
  
  // MARK: - Mockups
  init() {
    let book = Book(
      name: "Alice's Adventures in Wonderland by Lewis Carroll",
      image: "book_cover",
      chapters: [
        Chapter(fileName: "alices_adventures_01_carroll",
                chapterNumber: 1,
                name: "01 Down the Rabbit Hole",
                duration: 257),
        Chapter(fileName: "alices_adventures_02_carroll",
                chapterNumber: 2,
                name: "02 The Pool of Tears",
                duration: 177),
        Chapter(fileName: "alices_adventures_03_carroll",
                chapterNumber: 3,
                name: "03 A Caucus-Race and a Long Tale",
                duration: 55)
      ]
    )
    self.book = book
    self.currentChapter = book.chapters.first!
    self.isPlaying = false
    self.playbackRate = RateState(playbackRate: 1.0)
    self.currentTime = 0.0
    self.totalTime = TimeInterval(self.currentChapter.duration)
  }
}
