//
//  Book.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 05.08.2024.
//

import Foundation

struct Book: Equatable {
  let name: String
  let image: String
  let chapters: [Chapter]
}

struct Chapter: Equatable {
  let fileName: String
  let chapterNumber: Int
  let name: String
  let duration: Int
}
