//
//  Grade.swift
//  Teris
//
//  Created by User16 on 2019/1/11.
//  Copyright © 2019 User21. All rights reserved.
//
import Foundation

struct Grade : Codable {
    var score: Int
    var level: Int
    var date: String
    
    static func save(grade: [Grade]) {
        if let data = try? PropertyListEncoder().encode(grade) {
            UserDefaults.standard.set(data, forKey: "grades")
        }
    }
    
    static func read() -> [Grade]? {
        if let data = UserDefaults.standard.data(forKey: "grades"), let grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            return grade
        }
        else {
            return nil
        }
    }
    
    static func sort() {
        if let data = UserDefaults.standard.data(forKey: "grades"), var grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            grade.sort(by: {$0.score > $1.score})
        }
    }

    static func MaxScore() -> String? {
        if let data = UserDefaults.standard.data(forKey: "grades"), let grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            let result = grade.sorted(by: {$0.score > $1.score})
            print("score: ")
            print(result)
            return String(result[0].score)
        }
        else {
            return nil
        }
    }
    
    static func MaxLevel() -> String? {
        if let data = UserDefaults.standard.data(forKey: "grades"), let grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            let result = grade.sorted(by: {$0.level > $1.level})
            print("level: ")
            print(result)
            return String(result[0].level)
        }
        else {
            return nil
        }
    }
        
}
