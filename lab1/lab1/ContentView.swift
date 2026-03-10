//
//  ContentView.swift
//  lab1
//
//  Created by Abylai  on 13.02.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var index = 0
    @State private var tap = 0
    @State private var favorite: Set<Int> = []
    
    //    let ph = [
    //        "Tlou2",
    //        "spiderman"
    //    ]
    
    let ItemNames = [
        "The last of us 2",
        "Spider man",
        "Infamos: Second Son",
        "Dark Souls",
        "God of War",
        "Dying Light",
        "Red Dead Redemption",
        "Elden Ring",
        "Ghost of Tsushima",
        "Uncharted 4: A Thief's End"
    ]
    
    let itemIcons = [
        "heart.fill",
        "figure.climbing",
        "bolt.fill",
        "flame.fill",
        "hammer.fill",
        "moon.stars.fill",
        "figure.equestrian.sports",
        "sparkles",
        "wind",
        "map.fill"
    ]
    
    let itemDescriptions = [
        "Intense story-driven action in a post-apocalyptic world.",
        "Swing through NYC as the iconic web-slinger.",
        "Master superpowers in a vibrant open-world game.",
        "Brutally challenging action RPG with epic boss fights.",
        "Epic Norse adventure with Kratos and Atreus.",
        "Parkour and survival in a zombie apocalypse.",
        "Live the Wild West in this open-world masterpiece.",
        "Massive open-world RPG with brutal combat.",
        "Become a samurai defending Japan from invaders.",
        "Nathan Drake's final treasure hunting adventure."
    ]
    
    let ItemRatings = [
        6,
        8,
        8,
        9,
        5,
        3,
        4,
        5,
        7,
        3
    ]
    
    private var gradientColors: [Color] {
          let rating = ItemRatings[index]
           switch rating {
        case 0:
            return [.gray, .gray.opacity(0.6)]
           case 1...3:
            return [.green, .mint]
           case 4...5:
               return [.blue, .teal]
           case 6...7:
            return [.orange, .yellow]
           case 8...9:
               return [.red, .orange]
        case 10:
            return [.purple, .red]
        default:
            return [.orange, .orange.opacity(0.6)]
        }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(
                colors: gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                
                Image(systemName: itemIcons[index])
                    .font(.system(size: 100))
                    .foregroundStyle(Color.white.opacity(0.9))
                    .padding(.bottom, 10)
                //            Image(ph[index])
                //                .font(.system(size: 100))
                //                .foregroundStyle(Color.white.opacity(0.9))
                //                .padding(.bottom, 10)
                Text(ItemNames[index])
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white.opacity(0.9))
                    .padding(.bottom, 10)
                Divider()
                    .background(Color.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 5)
                Text(itemDescriptions[index])
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(Color.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 5){
                    Text("Difficulty:")
                        .font(.subheadline)
                        .foregroundStyle(Color.white.opacity(0.8))
                    Text(String(repeating: "💀", count: Int(ItemRatings[index])))
                        .font(.title2)
                }
                .padding(10)
                
                Spacer()
                //Button for the shuffling
                Button{
                    var newIndex: Int
                    repeat {
                        newIndex = Int.random(in: 0..<ItemNames.count)
                    } while newIndex == index
                    index = newIndex
                    
                    
                    tap+=1
                }label:{
                    Text("Surprise me!")
                        .foregroundStyle(Color.white)
                        .padding()
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                    
                }
                .padding()
                Text("Cards explored: \(tap)")
                    .foregroundStyle(Color.white.opacity(0.9))
            }
            .padding()
            .background(Color.orange.opacity(0.6))
            
        }
    }
}
#Preview {
    ContentView()
}
