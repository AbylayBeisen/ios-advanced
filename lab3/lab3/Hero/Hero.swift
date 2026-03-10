//
//  HeroInfo.swift
//  lab3
//
//  Created by Abylai  on 01.03.2026.
//

import Foundation

struct HeroModel: Identifiable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections

    struct Powerstats {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }

    struct Appearance {
        let gender: String
        let race: String?
        let height: String
        let weight: String
        let eyeColor: String
        let hairColor: String
    }

    struct Biography {
        let fullName: String
        let aliases: [String]
        let placeOfBirth: String
        let firstAppearance: String
        let publisher: String?
        let alignment: String
    }

    struct Work {
        let occupation: String
        let base: String
    }

    struct Connections {
        let groupAffiliation: String
        let relatives: String
    }
}
