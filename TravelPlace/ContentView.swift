import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView() // Подключение `MainTabView` для навигации
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
