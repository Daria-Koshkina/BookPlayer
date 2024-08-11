//
//  CustomToggle.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 08.08.2024.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
  let width: CGFloat
  let height: CGFloat
  let padding: CGFloat = 3
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      ZStack {
        Image(systemName: "headphones")
          .foregroundColor(!configuration.isOn ? .white : .black)
      }
      .frame(width: width, height: height)
      .background(
        ZStack {
          Circle()
            .fill(!configuration.isOn ? Color.blue : Color.white)
        }
      )
      .padding(padding)
      
      ZStack {
        Image(systemName: "line.horizontal.3")
          .foregroundColor(!configuration.isOn ? .black : .white)
      }
      .frame(width: width, height: height)
      .background(
        ZStack {
          Circle()
            .fill(configuration.isOn ? Color.blue : Color.white)
        }
      )
      .padding(padding)
    }
    .clipShape(RoundedRectangle(cornerRadius: (height + padding * 2) / 2))
    .overlay(
      RoundedRectangle(cornerRadius: (height + padding * 2) / 2)
        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
    )
    .onTapGesture {
      withAnimation {
        configuration.isOn.toggle()
      }
    }
  }
}
