//
//  ContentView.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showsGridView = true
    @State private var isPopoverPresented = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            Group {
                if showsGridView {
                    MissionsGridView(astronauts: astronauts, missions: missions)
                } else {
                    MissionsListView(astronauts: astronauts, missions: missions)
                }
            }
            .preferredColorScheme(.dark)
            .navigationTitle(Text("Moonshot"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                        .onTapGesture {
                            isPopoverPresented.toggle()
                        }
                        .popover(isPresented: $isPopoverPresented) {
                            Toggle("Show as Grid", isOn: $showsGridView)
                                .presentationCompactAdaptation((.popover))
                                .preferredColorScheme(.dark)
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
