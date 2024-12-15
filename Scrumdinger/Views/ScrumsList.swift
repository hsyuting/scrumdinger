//
//  ScrumsList.swift
//  Scrumdinger
//
//  Created by Allan Hsu on 2024-12-13.
//

import SwiftUI

struct ScrumsList: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    
    let saveAction: () -> Void
    
    var body: some View {
        List($scrums) { $scrum in
            NavigationLink(destination: DetailView(scrum: $scrum)) {
                CardView(scrum: scrum)
            }
            .listRowBackground(scrum.theme.mainColor)
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button(action: {
                isPresentingNewScrumView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .inactive {
                saveAction()
            }
        }
    }
}
#Preview {
    ScrumsList(scrums: .constant(DailyScrum.sampleData), saveAction: {})
}
