import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategory: String?

    let categories = ["Beaches", "Mountains", "Cultural Sites", "Adventure Activities"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .font(.subheadline)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(
                            selectedCategory == category
                                ? Color.blue.opacity(0.2)
                                : Color.gray.opacity(0.1)
                        )
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedCategory = selectedCategory == category ? nil : category
                        }
                }
            }
        }
    }
}
