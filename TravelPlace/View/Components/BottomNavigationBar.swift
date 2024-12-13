import SwiftUI

struct BottomNavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            NavBarItem(icon: "house.fill", title: "Home")
            Spacer()
            NavBarItem(icon: "magnifyingglass", title: "Explore")
            Spacer()
            NavBarItem(icon: "book.fill", title: "Bookings")
            Spacer()
            NavBarItem(icon: "heart.fill", title: "Favorites")
            Spacer()
            NavBarItem(icon: "person.fill", title: "Profile")
            Spacer()
        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
    }
}

struct NavBarItem: View {
    let icon: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBar()
            .previewLayout(.sizeThatFits)
    }
}
