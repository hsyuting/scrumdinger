//
//  ScrumsStackView.swift
//  Scrumdinger
//
//  Created by Allan Hsu on 2024-12-13.
//

import SwiftUI

@available(iOS 16.0, *)
struct ScrumsStackView: View  {
    @Binding var scrums: [DailyScrum]
    var body: some View {
        NavigationStack {
            ScrumsList(scrums: $scrums, saveAction: {})
        }
    }
}

#Preview {
    ScrumsStackView(scrums: .constant(DailyScrum.sampleData))
}
