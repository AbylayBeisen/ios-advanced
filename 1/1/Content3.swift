//
//  Content3.swift
//  1
//
//  Created by Abylai  on 14.02.2026.
//

import SwiftUI

struct Content3: View {
    @State private var counter: Int = 0
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Text("Counter: \(counter)")
                .foregroundStyle(colorScheme == .light ? . black : . white)
        }
    }
}
#Preview {
    Content3()
}
