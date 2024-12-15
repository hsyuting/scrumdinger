//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Allan Hsu on 2024-12-03.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                ProgressView(value:5, total: 15)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Seconds Elapsed")
                            .font(.caption)
                        Label("300", systemImage: "hourglass.tophalf.fill")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Seconds Remaining")
                        Label("600", systemImage: "hourglass.bottomhalf.fill")
                            .font(.caption)

                    }
                }
                .accessibilityElement(children:.ignore)
                .accessibilityLabel("Time Remaining")
                .accessibilityValue("10 minutes")
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear{
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
