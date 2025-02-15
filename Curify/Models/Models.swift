//
//  Models.swift
//  Curify
//
//  
//

import UIKit

struct Instruction {
    let title: String
    let image: UIImage
}

struct Language {
    let image: UIImage
    let name: String
    let language: AppLanguage
}

struct Scan {
    let title: String
    let image: Data
    let date: String
}
