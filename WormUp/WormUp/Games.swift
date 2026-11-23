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
                passi:[ Passo(titolo: "ahsdhdhdh", descrizione: "ahhshshs"),
                        Passo(titolo: "hsdsush", descrizione: "hshddhd"),
                        Passo(titolo: "hshsdhs", descrizione: "xhshsbsdhhd")
                      ] ),
    Instruction(categoria: "Attention", titolo: "Shape match", subtitle: "Find the shape that was only turned", immagine: Image("Attention"), im_In: Image("Attention 1"),
                passi:[ Passo(titolo: "ahsdhdhdh", descrizione: "ahhshshs"),
                                                                                                                                                                                
                        Passo(titolo: "hsdsush", descrizione: "hshddhd"),
                                                                                                                                                                                  
                        Passo(titolo: "hshsdhs", descrizione: "xhshsbsdhhd")
                                                                                                                                                                
                      ] ),
    
    Instruction(categoria: "Attention", titolo: "Shape match", subtitle: "Find the shape that was only turned", immagine: Image("Attention"), im_In: Image("Attention 1"),
                passi:[ Passo(titolo: "ahsdhdhdh", descrizione: "ahhshshs"),
                        Passo(titolo: "hsdsush", descrizione: "hshddhd"),
                        Passo(titolo: "hshsdhs", descrizione: "xhshsbsdhhd")
                      ] ),
    
    Instruction(categoria: "Attention", titolo: "Shape match", subtitle: "Find the shape that was only turned", immagine: Image("Attention"), im_In: Image("Attention 1"),
                passi:[ Passo(titolo: "ahsdhdhdh", descrizione: "ahhshshs"),
                        Passo(titolo: "hsdsush", descrizione: "hshddhd"),
                        Passo(titolo: "hshsdhs", descrizione: "xhshsbsdhhd")
                      ] )
]
