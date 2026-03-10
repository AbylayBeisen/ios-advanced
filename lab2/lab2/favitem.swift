//
//  favitem.swift
//  lab2
//
//  Created by Abylai  on 26.02.2026.
//

import Foundation

struct FavoriteItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let emoji: String
    var isFavorite: Bool = false
}
