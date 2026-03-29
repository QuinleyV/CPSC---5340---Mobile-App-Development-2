//
// FavoritesView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject private var favorites: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                if favorites.cities.contains(where: { $0.isFavorite }) {
                    Text("Cities")
                        .font(.headline)
                    
                    ForEach(favorites.cities.filter { $0.isFavorite }) { city in
                        CityCardView(city: city)
                    }
                }
                
                if favorites.hobbies.contains(where: { $0.isFavorite }) {
                    Text("Hobbies")
                        .font(.headline)
                    
                    ForEach(favorites.hobbies.filter { $0.isFavorite }) { hobby in
                        HobbyRowView(hobby: hobby)
                    }
                }
                
                if favorites.books.contains(where: { $0.isFavorite }) {
                    Text("Books")
                        .font(.headline)
                    
                    ForEach(favorites.books.filter { $0.isFavorite }) { book in
                        BookRowView(book: book)
                    }
                }
                
                if !favorites.cities.contains(where: { $0.isFavorite }) &&
                    !favorites.hobbies.contains(where: { $0.isFavorite }) &&
                    !favorites.books.contains(where: { $0.isFavorite }) {
                    Text("No favorites yet")
                        .foregroundColor(.gray)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
