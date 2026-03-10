//
//  sectionmanager.swift
//  lab2
//
//  Created by Abylai  on 26.02.2026.
//

import Foundation
import SwiftUI

struct SectionInfo {
    var movies: [FavoriteItem] = [
        FavoriteItem(title: "Inception",                subtitle: "Christopher Nolan · 2010",     emoji: "🌀"),
        FavoriteItem(title: "Interstellar",             subtitle: "Christopher Nolan · 2014",     emoji: "🪐"),
        FavoriteItem(title: "The Dark Knight",          subtitle: "Christopher Nolan · 2008",     emoji: "🦇"),
        FavoriteItem(title: "Parasite",                 subtitle: "Bong Joon-ho · 2019",          emoji: "🏠"),
        FavoriteItem(title: "The Godfather",            subtitle: "Francis Ford Coppola · 1972",  emoji: "🌹"),
        FavoriteItem(title: "Pulp Fiction",             subtitle: "Quentin Tarantino · 1994",     emoji: "💼"),
        FavoriteItem(title: "Spirited Away",            subtitle: "Hayao Miyazaki · 2001",        emoji: "🐉"),
        FavoriteItem(title: "The Shawshank Redemption", subtitle: "Frank Darabont · 1994",        emoji: "🔓"),
        FavoriteItem(title: "Whiplash",                 subtitle: "Damien Chazelle · 2014",       emoji: "🥁"),
        FavoriteItem(title: "Everything Everywhere All at Once", subtitle: "Daniels · 2022",      emoji: "🥯"),
    ]

    var games: [FavoriteItem] = [
        FavoriteItem(title: "Elden Ring",               subtitle: "FromSoftware · 2022",          emoji: "⚔️"),
        FavoriteItem(title: "The Witcher 3",            subtitle: "CD Projekt Red · 2015",        emoji: "🐺"),
        FavoriteItem(title: "Baldur's Gate 3",          subtitle: "Larian Studios · 2023",        emoji: "🎲"),
        FavoriteItem(title: "Hades",                    subtitle: "Supergiant Games · 2020",      emoji: "🔱"),
        FavoriteItem(title: "Hollow Knight",            subtitle: "Team Cherry · 2017",           emoji: "🦋"),
        FavoriteItem(title: "Celeste",                  subtitle: "Maddy Thorson · 2018",         emoji: "🏔️"),
        FavoriteItem(title: "Disco Elysium",            subtitle: "ZA/UM · 2019",                 emoji: "🕵️"),
        FavoriteItem(title: "Stardew Valley",           subtitle: "ConcernedApe · 2016",          emoji: "🌾"),
        FavoriteItem(title: "Persona 5 Royal",          subtitle: "Atlus · 2019",                 emoji: "🎭"),
        FavoriteItem(title: "DOOM Eternal",             subtitle: "id Software · 2020",           emoji: "👹"),
    ]

    var music: [FavoriteItem] = [
        FavoriteItem(title: "To Pimp a Butterfly",      subtitle: "Kendrick Lamar · 2015",        emoji: "🦋"),
        FavoriteItem(title: "OK Computer",              subtitle: "Radiohead · 1997",             emoji: "💻"),
        FavoriteItem(title: "The Dark Side of the Moon",subtitle: "Pink Floyd · 1973",            emoji: "🌑"),
        FavoriteItem(title: "Blonde",                   subtitle: "Frank Ocean · 2016",           emoji: "🌊"),
        FavoriteItem(title: "My Beautiful Dark Twisted Fantasy", subtitle: "Kanye West · 2010",   emoji: "🎨"),
        FavoriteItem(title: "Igor",                     subtitle: "Tyler, the Creator · 2019",    emoji: "🎭"),
        FavoriteItem(title: "In Rainbows",              subtitle: "Radiohead · 2007",             emoji: "🌈"),
        FavoriteItem(title: "good kid, m.A.A.d city",  subtitle: "Kendrick Lamar · 2012",        emoji: "🌆"),
        FavoriteItem(title: "Currents",                 subtitle: "Tame Impala · 2015",           emoji: "🌀"),
        FavoriteItem(title: "Thriller",                 subtitle: "Michael Jackson · 1982",       emoji: "🕺"),
    ]

     var books: [FavoriteItem] = [
        FavoriteItem(title: "Dune",                     subtitle: "Frank Herbert · 1965",         emoji: "🏜️"),
        FavoriteItem(title: "1984",                     subtitle: "George Orwell · 1949",         emoji: "👁️"),
        FavoriteItem(title: "The Brothers Karamazov",   subtitle: "Fyodor Dostoevsky · 1880",     emoji: "✝️"),
        FavoriteItem(title: "Sapiens",                  subtitle: "Yuval Noah Harari · 2011",     emoji: "🦴"),
        FavoriteItem(title: "Crime and Punishment",     subtitle: "Fyodor Dostoevsky · 1866",     emoji: "🪓"),
        FavoriteItem(title: "The Hitchhiker's Guide",   subtitle: "Douglas Adams · 1979",         emoji: "🌌"),
        FavoriteItem(title: "Meditations",              subtitle: "Marcus Aurelius · 180 AD",     emoji: "🏛️"),
        FavoriteItem(title: "Brave New World",          subtitle: "Aldous Huxley · 1932",         emoji: "🧬"),
        FavoriteItem(title: "The Name of the Wind",     subtitle: "Patrick Rothfuss · 2007",      emoji: "🎶"),
        FavoriteItem(title: "Flowers for Algernon",     subtitle: "Daniel Keyes · 1966",          emoji: "🌸"),
    ]
    var totalItems: Int {
        movies.count + games.count + music.count + books.count
    }

    var favoritedCount: Int {
        (movies + games + music + books).filter(\.isFavorite).count
    }
}
