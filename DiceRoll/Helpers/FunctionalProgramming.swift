//
//  FunctionalProgramming.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 22/12/2025.
//

import SwiftUI

struct FunctionalProgramming: View {
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Text("Imperative evens")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(evenImperative(from: 0, to: 100), id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            
            VStack {
                Text("Functional evens")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(evenFunctional(from: 0, to: 100), id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            
            VStack {
                Text("Map result: \(exampleCompactMap().first!)")
                Text("Compact map result: \(exampleCompactMap().last!)")
            }
        }
    }
    func evenImperative(from startNumber: Int, to endNumber: Int) -> Array<Int> {
        let numberArray = startNumber...endNumber
        var evens: [Int] = []
        
        for number in numberArray {
            if number.isMultiple(of: 2) {
                evens.append(number)
            }
        }
        
        return evens
    }
    func evenFunctional(from startNumber: Int, to endNumber: Int) -> Array<Int> {
        let numberArray = startNumber...endNumber
        
        return numberArray.filter { $0.isMultiple(of: 2) }
    }
    func exampleCompactMap() -> Array<Int> {
        let numbers = ["1", "2", "fish", "3"]
        let evensMap = numbers.map(Int.init)
        let evensCompactMap = numbers.compactMap(Int.init)
    
        return [evensMap.count, evensCompactMap.count]
    }
}

#Preview {
    FunctionalProgramming()
}
