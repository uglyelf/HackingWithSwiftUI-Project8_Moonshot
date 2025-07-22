//
//  MissionView.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/22/25.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    let mission: Mission
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map {
            if let astronaut = astronauts[$0.name] {
                return CrewMember(role: $0.role, astronaut: astronaut)
            } else {
                fatalError("Missing \($0.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 0.5)
                    
                    Text(mission.description)
                        
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id.role) { crewMember in
                            NavigationLink {
                                Text("Astronaut Details")
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                } // HStack
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            } // VStack
            .padding(.bottom)
        } // ScrollView
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    } // View
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
