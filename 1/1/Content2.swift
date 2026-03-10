//
//  Content2.swift
//  1
//
//  Created by Abylai  on 14.02.2026.
//

import SwiftUI

let arlan = ["ar"]

struct Content2: View {
    var body: some View {
//                ScrollView{
//                    VStack {
//                        ForEach(0...1000, id: \.self){number in
//                            Text("\(number)")
//                        }
//                    }
//                }
        List{
            Section("Numbers"){
                VStack {
                    ForEach(0...100, id: \.self){number in
                        Text("\(number)")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.green)
                            .cornerRadius(15)
                            .swipeActions(edge: .trailing){
                                Button(role: .destructive){
                                    Text("Delete")
                                }
                            }
                    }
                }
            }
            
        }
        .listStyle(.plain)
        .ignoresSafeArea(edges: .all)
    }
}
    #Preview {
        Content2()
    }

