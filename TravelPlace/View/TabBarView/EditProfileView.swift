import SwiftUI

struct EditProfileView: View {
    @Binding var fullName: String
    @Binding var nickname: String
    @Binding var profileImage: String
    @Environment(\.dismiss) var dismiss

    let availableIcons = ["person.circle.fill", "star.circle.fill", "heart.circle.fill", "house.circle.fill"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Full Name")) {
                    TextField("Enter your full name", text: $fullName)
                }

                Section(header: Text("Nickname")) {
                    TextField("Enter your nickname", text: $nickname)
                }

                Section(header: Text("Profile Image")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(availableIcons, id: \.self) { icon in
                                Button(action: {
                                    profileImage = icon
                                }) {
                                    Image(systemName: icon)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(profileImage == icon ? .blue : .gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}
