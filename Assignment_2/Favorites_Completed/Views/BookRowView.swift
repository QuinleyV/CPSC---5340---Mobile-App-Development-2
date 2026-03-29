import SwiftUI

struct BookRowView: View {
    
    let book: BookModel
    @EnvironmentObject private var favorites: FavoritesViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.bookTitle)
                    .font(.headline)
                
                Text(book.bookAuthor)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                favorites.toggleFavoriteBook(book: book)
            } label: {
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(book.isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookRowView(book: BookModel(id: 1, bookTitle: "1984", bookAuthor: "George Orwell"))
        .environmentObject(FavoritesViewModel())
}
