//
//  Content.swift
//  1
//
//  Created by Abylai  on 07.02.2026.
//

import SwiftUI

struct Content: View {
    var body: some View {
    VStack {
        Spacer()
        Button{
            
        } label:{
            Text("Press me")
                .font(.largeTitle)
                .foregroundStyle(Color.white)
                .padding(20)
                .background(Color.red)
                .cornerRadius(20)
        }
        }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.green)
    }
}
#Preview {
    Content()
}
