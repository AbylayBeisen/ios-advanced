//
//  ContentView.swift
//  lab2
//
//  Created by Abylai  on 21.02.2026.
//

import SwiftUI

struct FavoriteRow: View {
    let item: FavoriteItem
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            
            Text(item.emoji)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: onToggle) {
                Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(item.isFavorite ? .red : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

struct SectionHeader: View {
    let title:  String
    let icon:  String
    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
        }
        .buttonStyle(.plain)
    }
}

struct Favoriteitemlist: View{
    
    let movies: [FavoriteItem]
    let games: [FavoriteItem]
    let music: [FavoriteItem]
    let books: [FavoriteItem]
    
    private func section(_ title: String, icon: String, items: [FavoriteItem]) -> some View{
        Group{
            if !items.isEmpty{
                Section{
                    ForEach(items){ item in
                        HStack{
                            Text(item.emoji)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            VStack(alignment: .leading, spacing: 3) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.subtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "heart.fill")
                                .font(.title3)
                                .foregroundStyle(.red)
                            
                        }
                        .padding(.vertical, 6)
                    }
                }header: {
                    
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationStack{
            let favmovies = movies.filter(\.isFavorite)
            let favgames = games.filter(\.isFavorite)
            let favmusic = music.filter(\.isFavorite)
            let favbooks = books.filter(\.isFavorite)
            let isEmpty = favbooks.isEmpty && favmovies.isEmpty && favgames.isEmpty && favmusic.isEmpty
            
            List{
                if isEmpty {
                    ContentUnavailableView{
                        Label("No Favorites Yet", systemImage: "star")
                    }description: {
                        Text("Come back when you like something!")
                    }
                }else{
                    section("Movies", icon: "film.fill", items: favmovies)
                    section("Games" , icon:"gamecontroller.fill", items: favgames)
                    section("Music", icon: "music.note" , items: favmusic)
                    section("Books", icon : "book.fill", items: favbooks)
                }
            }
            .navigationTitle("My Favorites")
            .navigationBarTitleDisplayMode(.large)
           
        }
    }
}

struct ContentView: View {

    @State private var moviesExpanded = true
    @State private var gamesExpanded  = true
    @State private var musicExpanded  = true
    @State private var booksExpanded  = true
    @State private var info = SectionInfo()
    @State private var showFavorites = false

    var body: some View {
        NavigationStack {
            List {

                Section {
                    if moviesExpanded {
                        ForEach($info.movies) { $item in
                            FavoriteRow(item: item) { item.isFavorite.toggle() }
                        }
                    }
                } header: {
                    SectionHeader(
                        title: "Movies",
                        icon: "film.fill",
                        isExpanded: moviesExpanded
                    ) { moviesExpanded.toggle() }
                }
                
                Section {
                    if gamesExpanded {
                        ForEach($info.games) { $item in
                            FavoriteRow(item: item) { item.isFavorite.toggle() }
                        }
                    }
                } header: {
                    SectionHeader(
                        title: "Games",
                        icon: "gamecontroller.fill",
                        isExpanded: gamesExpanded
                    ) { gamesExpanded.toggle() }
                }

                Section {
                    if musicExpanded {
                        ForEach($info.music) { $item in
                            FavoriteRow(item: item) { item.isFavorite.toggle() }
                        }
                    }
                } header: {
                    SectionHeader(
                        title: "Music",
                        icon: "music.note",
                        isExpanded: musicExpanded
                    ) { musicExpanded.toggle() }
                }

                Section {
                    if booksExpanded {
                        ForEach($info.books) { $item in
                            FavoriteRow(item: item) { item.isFavorite.toggle() }
                        }
                    }
                } header: {
                    SectionHeader(
                        title: "Books",
                        icon: "book.fill",
                        isExpanded: booksExpanded
                    ) { booksExpanded.toggle() }
                }

                Section {
                    HStack {
                        Label("\(info.totalItems) items total", systemImage: "list.bullet")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Label("\(info.favoritedCount) favorited", systemImage: "heart.fill")
                            .font(.footnote)
                            .foregroundStyle(.pink)
                    }
                    .padding(.vertical, 4)
                }
                Button {
                    showFavorites = true
                } label: {
                    HStack {
                        Spacer()
                        Label("See All Favorites", systemImage: "heart.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                        Spacer()
                }
                        .padding(.vertical, 10)
                        .background(info.favoritedCount == 0 ? Color.gray: Color.pink)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                                .buttonStyle(.plain)
                                .disabled(info.favoritedCount == 0)
                                .padding(.vertical, 4)
                    }
            }
            .navigationTitle(" My List")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showFavorites) {
                Favoriteitemlist(
                    movies: info.movies,
                    games:  info.games,
                    music:  info.music,
                    books:  info.books
                )
            }
        }
    }



#Preview {
    ContentView()
}
