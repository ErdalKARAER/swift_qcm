    //
    //  ContentView.swift
    //  TestSubDeVinci
    //
    //  Created by Guillaume on 16/04/2024.
    //

    import SwiftUI
    import CoreData

    struct ConnectionView: View {
        @State private
        var username: String = ""
        @State private
        var password: String = ""
        @State private
        var pseudo: String = ""
        @State private
        var firstName: String = ""
        @State private
        var familyName: String = ""
        @State private
        var passwordSignUp: String = ""
        @State private
        var confirmPassword: String = ""
        @State private
        var showingAlert = false
        @State private
        var showingAlertSignUp: Bool = false
        @State private
        var isAdmin: Bool = false
        @State private var isUserLoggedIn = false
        @State private var isUserLoggedInAdmin = false
        
        

        var body: some View {
            NavigationView {
                VStack {
                    Text("Connectez-vous :")
                        .font(.headline)
                        .padding(.top)
                    
                    TextField("Pseudo", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Mot de passe", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .textContentType(.oneTimeCode)
                    
                    NavigationLink("", destination: QCMView(), isActive: $isUserLoggedIn)
                    
                    NavigationLink("", destination: AdminView(), isActive: $isUserLoggedInAdmin)
                    
                    Button(action: {
                        login()
                    }) {
                        Text("Connexion")
                            .foregroundColor(.white)
                            .frame(width: 220, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Erreur"), message: Text("Veuillez remplir tous les champs requis."), dismissButton: .default(Text("OK")))
                    }
                    .padding()
                    Divider()
                        .padding()
                    Text("Inscrivez vous :")
                    
                    TextField("Pseudo", text: $pseudo)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Prenom", text: $firstName)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("Nom de famille", text: $familyName)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Toggle(isOn: $isAdmin) {
                        Text("Admin")
                    }
                    SecureField("Password", text: $passwordSignUp)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .textContentType(.oneTimeCode)
                    SecureField("Confirm password", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .textContentType(.oneTimeCode)
                    
                    Button(action: {
                        signUp()
                    }) {
                        Text("Inscription")
                            .foregroundColor(.white)
                            .frame(width: 220, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    }
                    .alert(isPresented: $showingAlertSignUp) {
                        Alert(title: Text("Erreur"), message: Text("Les mot de passe ne correspondent pas"), dismissButton: .default(Text("OK")))
                    }
                }

                    .padding()
            }
            .padding()
        }
        private var context: NSManagedObjectContext {
               return PersistenceController.shared.container.viewContext
           }
        
        private func signUp() {
            if passwordSignUp != confirmPassword{
                showingAlertSignUp = true
                return
            }
            let newUser = User(context: context)
            newUser.pseudo = pseudo
            newUser.firstName = firstName
            newUser.familyName = familyName
            newUser.isAdmin = isAdmin
            newUser.password = passwordSignUp

            do {
                try context.save()
                print("User successfully saved.")
                print(newUser)
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        func fetchUser(byUsername username: String, andPassword password: String) -> User? {
                let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "pseudo == %@ AND password == %@", username, password)
                
                do {
                    let results = try context.fetch(fetchRequest)
                    return results.first
                } catch {
                    print("Error fetching user: \(error)")
                    return nil
                }
            }
        
        private func login() {
            if username.isEmpty || password.isEmpty {
                showingAlert = true
                return
            }
            let user = fetchUser(byUsername: username, andPassword: password)
                if let user = user {
                    if(user.isAdmin == false){
                        isUserLoggedIn = true
                        print("Login successful for user: \(user.pseudo)")
                    }
                    else{
                        isUserLoggedInAdmin = true
                        print("Login successful for user: \(user.pseudo)")
                    }
                   
                }
        }
    }


    #Preview {
        ConnectionView()
    }
