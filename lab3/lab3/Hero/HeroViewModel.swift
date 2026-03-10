//
//  HeroViewModel.swift
//  lab3
//
//  Created by Abylai  on 06.03.2026.
//

import Foundation
import Combine

final class HeroViewModel: ObservableObject {

    @Published var hero: HeroModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func randomizeHero() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
            hero = nil
        }

        let response = await HeroService.shared.fetchHero(id: HeroService.shared.randomID())

        await MainActor.run {
            if let response {
                self.hero = HeroModel(
                    id: response.id,
                    name: response.name,
                    imageUrl: URL(string: response.images.lg),
                    powerstats: HeroModel.Powerstats(
                        intelligence: response.powerstats.intelligence,
                        strength: response.powerstats.strength,
                        speed: response.powerstats.speed,
                        durability: response.powerstats.durability,
                        power: response.powerstats.power,
                        combat: response.powerstats.combat
                    ),
                    appearance: HeroModel.Appearance(
                        gender: response.appearance.gender,
                        race: response.appearance.race,
                        height: response.appearance.height.first ?? "-",
                        weight: response.appearance.weight.first ?? "-",
                        eyeColor: response.appearance.eyeColor,
                        hairColor: response.appearance.hairColor
                    ),
                    biography: HeroModel.Biography(
                        fullName: response.biography.fullName,
                        aliases: response.biography.aliases,
                        placeOfBirth: response.biography.placeOfBirth,
                        firstAppearance: response.biography.firstAppearance,
                        publisher: response.biography.publisher,
                        alignment: response.biography.alignment
                    ),
                    work: HeroModel.Work(
                        occupation: response.work.occupation,
                        base: response.work.base
                    ),
                    connections: HeroModel.Connections(
                        groupAffiliation: response.connections.groupAffiliation,
                        relatives: response.connections.relatives
                    )
                )
            } else {
                self.errorMessage = "Try again."
            }
            self.isLoading = false
        }
    }

    func normalizedStat(_ value: Int) -> Double {
        Double(value) / 100.0
    }
}
