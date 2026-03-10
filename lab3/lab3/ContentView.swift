//
//  ContentView.swift
//  lab3
//
//  Created by Abylai  on 01.03.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HeroViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerView
                    .padding(.top, 8)

                ScrollView {
                    VStack(spacing: 20) {
                        if viewModel.isLoading {
                            loadingView
                        } else if let error = viewModel.errorMessage {
                            errorView(message: error)
                        } else if let hero = viewModel.hero {
                            heroCardView(hero: hero)
                        } else {
                            idleView
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 120)
                }
            }

            VStack {
                Spacer()
                randomizeButton
                    .padding(.bottom, 32)
                    .padding(.horizontal, 32)
            }
        }
    }

    private var headerView: some View {
        HStack {
            Text("HeroRandomizer")
                .font(.title2.bold())
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    private var idleView: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 60)
            Text("Tap the button below\nto meet your hero!")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.6))
                .padding(20)
            Spacer(minLength: 60)
        }
    }

    private var loadingView: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 80)
            Text("Summoning hero...")
                .font(.headline)
                .foregroundStyle(.white.opacity(0.7))
            Spacer(minLength: 80)
        }
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Spacer(minLength: 60)
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 52))
                .foregroundStyle(.orange)
            Text("Something went wrong")
                .font(.title3.bold())
                .foregroundStyle(.white)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
                .multilineTextAlignment(.center)
            Button("Try Again") {
                Task { await viewModel.randomizeHero() }
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            Spacer(minLength: 60)
        }
    }

    private func heroCardView(hero: HeroModel) -> some View {
        VStack(spacing: 16) {
            heroImageBanner(hero: hero)
            biographySection(bio: hero.biography)
            appearanceSection(appearance: hero.appearance)
            powerstatsSection(powerstats: hero.powerstats)
            workConnectionsSection(work: hero.work, connections: hero.connections)
        }
    }

    private func heroImageBanner(hero: HeroModel) -> some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: hero.imageUrl) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle().fill(Color.white.opacity(0.05))
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .scaleEffect(1.4)
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    ZStack {
                        Rectangle().fill(Color.white.opacity(0.05))
                        Image(systemName: "photo.slash")
                            .font(.system(size: 40))
                            .foregroundStyle(.white.opacity(0.3))
                    }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 340)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            LinearGradient(
                colors: [.clear, .black.opacity(0.85)],
                startPoint: .center,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(hero.name)
                        .font(.system(size: 32, weight: .black))
                        .foregroundStyle(.white)
                    if !hero.biography.fullName.isEmpty,
                       hero.biography.fullName != hero.name {
                        Text(hero.biography.fullName)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.75))
                    }
                }
                Spacer()
                alignmentBadge(hero.biography.alignment)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.4), radius: 16, x: 0, y: 8)
    }

    private func alignmentBadge(_ alignment: String) -> some View {
        let color: Color = {
            switch alignment.lowercased() {
            case "good": return .green
            case "bad":  return .red
            default:     return .orange
            }
        }()
        let icon: String = {
            switch alignment.lowercased() {
            case "good": return "hand.thumbsup.fill"
            case "bad":  return "bolt.fill"
            default:     return "minus.circle.fill"
            }
        }()
        return HStack(spacing: 4) {
            Image(systemName: icon).font(.caption2.bold())
            Text(alignment.capitalized).font(.caption.bold())
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(color.opacity(0.85), in: Capsule())
    }

    private func biographySection(bio: HeroModel.Biography) -> some View {
        sectionCard(title: "Biography", icon: "book.fill", iconColor: .blue) {
            VStack(spacing: 0) {
                infoRow(label: "Publisher",        value: bio.publisher ?? "Unknown")
                Divider().background(.white.opacity(0.1))
                infoRow(label: "First Appearance", value: bio.firstAppearance)
                Divider().background(.white.opacity(0.1))
                infoRow(label: "Place of Birth",   value: bio.placeOfBirth)
                if !bio.aliases.isEmpty {
                    Divider().background(.white.opacity(0.1))
                    infoRow(label: "Aliases", value: bio.aliases.joined(separator: ", "))
                }
            }
        }
    }

    private func appearanceSection(appearance: HeroModel.Appearance) -> some View {
        sectionCard(title: "Appearance", icon: "eye.fill", iconColor: .purple) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                appearanceTile(label: "Gender",     value: appearance.gender,            icon: "person.fill")
                appearanceTile(label: "Race",       value: appearance.race ?? "Unknown", icon: "globe")
                appearanceTile(label: "Height",     value: appearance.height,            icon: "arrow.up.and.down")
                appearanceTile(label: "Weight",     value: appearance.weight,            icon: "scalemass.fill")
                appearanceTile(label: "Eye Color",  value: appearance.eyeColor,          icon: "eye.circle.fill")
                appearanceTile(label: "Hair Color", value: appearance.hairColor,         icon: "camera.filters")
            }
        }
    }

    private func appearanceTile(label: String, value: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
                .frame(width: 16)
            VStack(alignment: .leading, spacing: 1) {
                Text(label)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))
                Text(value)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 10))
    }

    private func powerstatsSection(powerstats: HeroModel.Powerstats) -> some View {
        let stats: [(String, Int, Color)] = [
            ("Intelligence", powerstats.intelligence, .cyan),
            ("Strength",     powerstats.strength,     .red),
            ("Speed",        powerstats.speed,         .yellow),
            ("Durability",   powerstats.durability,    .orange),
            ("Power",        powerstats.power,         .purple),
            ("Combat",       powerstats.combat,        .green),
        ]
        return sectionCard(title: "Powerstats", icon: "bolt.fill", iconColor: .yellow) {
            VStack(spacing: 10) {
                ForEach(stats, id: \.0) { name, value, color in
                    statBar(name: name, value: value, color: color,
                            normalized: viewModel.normalizedStat(value))
                }
            }
        }
    }

    private func statBar(name: String, value: Int, color: Color, normalized: Double) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(name)
                    .font(.caption.bold())
                    .foregroundStyle(.white.opacity(0.85))
                Spacer()
                Text("\(value)")
                    .font(.caption.bold())
                    .foregroundStyle(color)
                    .monospacedDigit()
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white.opacity(0.1))
                        .frame(height: 8)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(
                            colors: [color.opacity(0.7), color],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: geo.size.width * normalized, height: 8)
                }
            }
            .frame(height: 8)
        }
    }

    private func workConnectionsSection(work: HeroModel.Work, connections: HeroModel.Connections) -> some View {
        sectionCard(title: "Work & Connections", icon: "network", iconColor: .teal) {
            VStack(spacing: 0) {
                infoRow(label: "Occupation",   value: work.occupation)
                Divider().background(.white.opacity(0.1))
                infoRow(label: "Base",         value: work.base)
                Divider().background(.white.opacity(0.1))
                infoRow(label: "Affiliations", value: connections.groupAffiliation)
                Divider().background(.white.opacity(0.1))
                infoRow(label: "Relatives",    value: connections.relatives)
            }
        }
    }

    private var randomizeButton: some View {
        Button {
            Task { await viewModel.randomizeHero() }
        } label: {
            HStack(spacing: 10) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(0.9)
                } else {
                    Image(systemName: "shuffle").font(.headline)
                }
                Text(viewModel.isLoading ? "Loading..." : "Randomize Hero")
                    .font(.headline.bold())
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                viewModel.isLoading ? Color.yellow.opacity(0.6) : Color.yellow,
                in: Capsule()
            )
            .shadow(color: .yellow.opacity(0.4), radius: 12, x: 0, y: 6)
        }
        .disabled(viewModel.isLoading)
        .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)
    }

    private func sectionCard<Content: View>(
        title: String,
        icon: String,
        iconColor: Color,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.subheadline.bold())
                    .foregroundStyle(iconColor)
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
            }
            content()
        }
        .padding(16)
        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.white.opacity(0.1), lineWidth: 1)
        )
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
                .frame(width: 110, alignment: .leading)
            Text(value.isEmpty || value == "-" ? "Unknown" : value)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 7)
    }
}

#Preview {
    ContentView()
}
