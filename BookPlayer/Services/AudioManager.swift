//
//  AudioManager.swift
//  BookPlayer
//
//  Created by Dasha Koshkina on 07.08.2024.
//

import Foundation
import AVFoundation

class AudioManager {
  
  // MARK: - Singleton
  static let shared = AudioManager()
    
  // MARK: - Public variables
  var isPlaying: Bool {
    return audioPlayer?.isPlaying ?? false
  }
  var playbackPosition: TimeInterval {
    audioPlayer?.currentTime ?? 0
  }
  var duration: TimeInterval {
    audioPlayer?.duration ?? 0
  }
  
  // MARK: - Private variables
  private var audioPlayer: AVAudioPlayer?
  
  private init() {
    setupAudioSession()
  }
  
  // MARK: - Methods
  func playSound(named name: String) {
    guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
      print("Sound file not found")
      return
    }
    
    do {
      if audioPlayer == nil || !isPlaying {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.currentTime = playbackPosition
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
      } else {
        print("Sound is already playing")
      }
    } catch {
      print("Error playing sound: \(error.localizedDescription)")
    }
  }
  
  func stopSound() {
    if let player = audioPlayer {
      player.stop()
    }
  }
  
  func rewind(by seconds: TimeInterval) {
    guard let player = audioPlayer else { return }
    player.currentTime = max(player.currentTime - seconds, 0)
  }
  
  func fastForward(by seconds: TimeInterval) {
    guard let player = audioPlayer else { return }
    player.currentTime = min(player.currentTime + seconds, player.duration)
  }
  
  func setPlaybackRate(rate: Float) {
    guard let player = audioPlayer else { return }
    player.stop()
    player.enableRate = true
    player.rate = rate
    player.play()
  }
  
  func setCurrentPlayTime(_ seconds: TimeInterval) {
    guard let player = audioPlayer else { return }
    player.currentTime = min(max(seconds, 0), player.duration)
  }
  
  private func setupAudioSession() {
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print("Failed to set up audio session: \(error)")
    }
  }
}
