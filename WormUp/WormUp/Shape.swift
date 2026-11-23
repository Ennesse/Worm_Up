//
//  Shape.swift
//  WormUp
//
//  Created by Siria Neri on 23/11/2026.
//

import Foundation
import SwiftUI

let bluGioco = Color(red: 0.31, green: 0.36, blue: 0.67)
let rosaGioco = Color(red: 1.0, green: 0.91, blue: 0.91)

let pentomini: [[[Int]]] = [
    [[0,1],[0,2],[1,0],[1,1],[2,1]],
    [[0,0],[1,0],[2,0],[3,0],[3,1]],
    [[0,1],[1,1],[2,0],[2,1],[3,0]],
    [[0,0],[0,1],[1,0],[1,1],[2,0]],
    [[0,1],[1,0],[1,1],[2,1],[3,1]]
]

func normalizza(_ forma: [[Int]]) -> [[Int]] {
    let minR = forma.map { $0[0] }.min()!
    let minC = forma.map { $0[1] }.min()!
    return forma.map { [$0[0] - minR, $0[1] - minC] }
}

func ruota(_ forma: [[Int]]) -> [[Int]] {
    return normalizza(forma.map { [$0[1], -$0[0]] })
}

func specchia(_ forma: [[Int]]) -> [[Int]] {
    return normalizza(forma.map { [$0[0], -$0[1]] })
}

func ruotaVolte(_ forma: [[Int]], volte: Int) -> [[Int]] {
    var risultato = forma
    for _ in 0..<volte {
        risultato = ruota(risultato)
    }
    return risultato
}

struct Opzione: Identifiable {
    let id = UUID()
    let forma: [[Int]]
    let giusta: Bool
}

struct ShapeView: View {
    let forma: [[Int]]
    let lato: CGFloat
    
    var body: some View {
        let righe = forma.map { $0[0] }.max()! + 1
        let colonne = forma.map { $0[1] }.max()! + 1
        
        VStack(spacing: 3) {
            ForEach(0..<righe, id: \.self) { r in
                HStack(spacing: 3) {
                    ForEach(0..<colonne, id: \.self) { c in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(forma.contains([r, c]) ? bluGioco : Color.clear)
                            .frame(width: lato, height: lato)
                    }
                }
            }
        }
    }
}
