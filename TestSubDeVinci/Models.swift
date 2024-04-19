//
//  Model.swift
//  TestSubDeVinci
//
//  Created by Guillaume on 16/04/2024.
//

import Foundation

class Model {
    let questions: [Question] = [
        Question(
            statement: "Sur quel environnement peut-on utiliser XCode ?" ,
            proposal: [
                "Uniquement avec les PC Windows.",
                "Uniquement les Macs.",
                "Les deux. Ça n'a pas d'importance."
            ],
            answer: .two
        ),
        Question(
            statement: "Que signifie MVVM ?",
            proposal: [
                "Model, Value, View, Movement",
                "Model, View, ViewModel",
                "Modal, Value, ViewModal"
            ],
            answer: .two
        ),
        Question(
            statement: "Quel framework est utilisé par Swift ?",
            proposal: [
                "VirtualWire",
                "Cocoa Touch",
                "Serial"
            ],
            answer: .two
        ),
        Question(
            statement: "Quels sont les éléments d'une variable ?",
            proposal: [
                "Un type et une valeur.",
                "Un nom, un singleton et un type.",
                "Un nom, un type et une valeur."
            ],
            answer: .three
        ),
        Question(
            statement: "Avec UIKit, qu'utilise-t-on pour lier une vue au storyBoard ?",
            proposal: [
                "Le mot clé @IBOutlet",
                "Le mot clé @IBAction",
                "Le mot clé @Published"
            ],
            answer: .three
        ),
        Question(
            statement: "Quelle est l'utilité d'un singleton",
            proposal: [
                "Ce n'est pas la peine d'utiliser un Model.",
                "Il permet de rectifier les fichiers audio.",
                "Cela génère une instance unique."
            ],
            answer: .three
        ),
        Question(
            statement: "'struct MainView: some View' doit contenir",
            proposal: [
                "var body: someView",
                "#Preview { }",
                "Un initialiseur"
            ],
            answer: .one
        ),
        Question(
            statement: "Quel est ce type : Chien?",
            proposal: [
                "C'est Kiki !!! Je l'ai vu en rêve cette nuit.",
                "C'est un type Chien",
                "C'est un optionnel"
            ],
            answer: .two
        ),
        Question(
            statement: "Comment retourne-t-on une valeur avec un dictionnaire ?",
            proposal: [
                "Avec un index",
                "Avec une clé",
                "Par concaténation"
            ],
            answer: .two
        ),
        Question(
            statement: "Quel est le principe de la View et du Model",
            proposal: [
                "Ils ne se parlent pas",
                "Ils peuvent se voir de temps en temps",
                "Ils discutent en permanence"
            ],
            answer: .one
        )
    ]
}

struct Question {
    let statement: String
    let proposal: [String]
    let answer: possibleAnswers
}

enum possibleAnswers: Int {
    case one = 1
    case two = 2
    case three = 3
}
