//
//  HeroModel.swift
//  lab3
//
//  Created by Abylai  on 06.03.2026.
//

import Foundation

final class HeroService {
    static let shared = HeroService()

    private init() {}

    func fetchHero(id: Int) async -> HeroResponse? {
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/id/\(id).json") else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(HeroResponse.self, from: data)
        } catch {
            debugPrint(error)
            return nil
        }
    }

    func randomID() -> Int {
        Int.random(in: 1...731)
    }
}
