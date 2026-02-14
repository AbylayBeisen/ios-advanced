//
//  ContentView.swift
//  1
//
//  Created by Abylai  on 07.02.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(Color.blue)
            Text("I Am Rich")
                .padding()
                .font(.largeTitle)
                .foregroundStyle(Color.yellow)
        }
        .frame()
        
    }
}

#Preview {
    ContentView()
}
