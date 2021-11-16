//
//  Model.swift
//  ParseJson
//
//  Created by Рамазан Нуриев on 15.11.2021.
//

import Foundation


struct Lesson: Decodable {
    let name: String
    let text: String
    let image: String
    let price: String
    let date: Date?

}


