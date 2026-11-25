//
//  Games.swift
//  WormUp
//
//  Created by Siria Neri on 23/11/2026.
//

import Foundation
import SwiftUI

struct Passo {
    let titolo : String
    let descrizione : String
}

struct Instruction {
    let id = UUID()
    let categoria : String
    let titolo : String
    let subtitle : String
    let immagine : Image
    let im_In : Image
    let passi : [Passo]
}
let all : [Instruction] = [
    Instruction(categoria: "Attention", titolo: "Shape match", subtitle: "Find the shape that was only turned", immagine: Image("Attention"), im_In: Image("Attention 1"),
                passi:[ Passo(titolo: "Look", descrizione: "Study the reference shape and notice its corners and short arms."),
                        Passo(titolo: "Turn", descrizione: "Turn it in your mind. Rotating is fine, flipping is not."),
                        Passo(titolo: "Pick", descrizione: "Tap the one that matches. Mirror images and moved blocks don't count.")
                      ] ),
    
    Instruction(categoria: "Language", titolo: "Word maker", subtitle: "Make words using only the letters you're given", immagine: Image("Language"), im_In: Image("Language"),
                passi:[
                    Passo(titolo: "Look", descrizione: "Study the letters you are given."),
                    Passo(titolo: "Build", descrizione: "Tap letters to make a word of 3 or more letters."),
                    Passo(titolo: "Find", descrizione: "Find at least 10 different words before time runs out.")
                    ] ),
    
    Instruction(categoria: "Attention", titolo: "Shape match", subtitle: "Find the shape that was only turned", immagine: Image("Attention"), im_In: Image("Attention 1"),
                passi:[ Passo(titolo: "ahsdhdhdh", descrizione: "ahhshshs"),
                        Passo(titolo: "hsdsush", descrizione: "hshddhd"),
                        Passo(titolo: "hshsdhs", descrizione: "xhshsbsdhhd")
                      ] ),
    
    Instruction(categoria: "Logic", titolo: "Number sequences", subtitle: "Find the rule and complete the sequence", immagine: Image("Logic"), im_In: Image("Logic"),
                passi:[ Passo(titolo: "Look", descrizione: "Read the numbers and notice how they change."),
                        Passo(titolo: "Find", descrizione: "Look for the rule: adding, multiplying, squares and more."),
                        Passo(titolo: "Pick", descrizione: "Choose the number that completes the sequence, then read why.")
                      ] )
]
