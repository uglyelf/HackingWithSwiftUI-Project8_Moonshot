//
//  ContentView.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/2/25.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
//    let layout = [
////        GridItem(.adaptive(minimum: 80, maximum: 120)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
//    ]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        } // Label
                    } // ForEach
                } // LazyVGrid
                .padding([.horizontal, .bottom])
            } // ScrollView
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationTitle(Text("Moonshot"))
        }
    }
}

#Preview {
    ContentView()
}


/*
 struct User: Codable {
 let name: String
 let address: Address
 }
 
 struct Address: Codable {
 let street: String
 let city: String
 }
 
 struct CustomText: View {
 let text: String
 
 var body: some View {
 Text(text)
 }
 
 init(_ text: String) {
 print("Creating a new CustomText \(text)")
 self.text = text
 }
 }
 */
