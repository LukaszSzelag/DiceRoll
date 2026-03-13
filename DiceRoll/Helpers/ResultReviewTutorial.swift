//
//  ResultReviewTutorial.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 22/12/2025.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

func createResult() -> Result<String, NetworkError> {
    return .failure(.badURL)
}

let result = createResult()
//let differentResult = Result { try String(contentsOf: someURL)}

//do {
//    let successString = try result.get()
//    print(successString)
//} catch {
//    print("Oops! There was an error.")
//}
