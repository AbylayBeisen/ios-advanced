//
//  Heroresponse.swift
//  lab3
//
//  Created by Abylai  on 06.03.2026.
//
import Foundation

struct HeroResponse: Decodable {
    let id: Int
    let name: String
    let powerstats: PowerstatsResponse
    let appearance: AppearanceResponse
    let biography: BiographyResponse
    let work: WorkResponse
    let connections: ConnectionsResponse
    let images: ImagesResponse
}

struct PowerstatsResponse: Decodable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct AppearanceResponse: Decodable {
    let gender: String
    let race: String?
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
}

struct BiographyResponse: Decodable {
    let fullName: String
    let aliases: [String]
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String?
    let alignment: String
}

struct WorkResponse: Decodable {
    let occupation: String
    let base: String
}

struct ConnectionsResponse: Decodable {
    let groupAffiliation: String
    let relatives: String
}

struct ImagesResponse: Decodable {
        let xs: String
        let sm: String
        let md: String
        let lg: String
}
