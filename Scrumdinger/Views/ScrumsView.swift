//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Allan Hsu on 2024-12-09.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ScrumsList(scrums: $scrums, saveAction: saveAction)
            }
        } else {
            NavigationView {
                ScrumsList(scrums: $scrums, saveAction: saveAction)
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
