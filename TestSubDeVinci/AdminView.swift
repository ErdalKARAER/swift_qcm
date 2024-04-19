import SwiftUI
import CoreData

struct AdminView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.pseudo, ascending: true)
        ]
    ) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    HStack {
                        Text("\(user.pseudo)")
                        Spacer()
                        Text("\(user.lastScore)")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("User Scores")
        }
    }
}

#Preview {
    AdminView()
}
