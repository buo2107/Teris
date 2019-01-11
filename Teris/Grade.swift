//
//  Grade.swift
//  Teris
//
//  Created by User16 on 2019/1/11.
//  Copyright © 2019 User21. All rights reserved.
//
import Foundation

struct Grade : Codable {
    var score: String
    var level: String
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
  /*
    static func sort() {
        if let data = UserDefaults.standard.data(forKey: "grades"), var grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            grade.sort( by: { $0.score > $1.score } )
          //////////////////////
            for i in 0..<grade.count-1 {
                for j in 0..<grade.count-i-1 {
                    if grade[j].score.compare(grade[j+1].score, options: .numeric) == .orderedAscending { // grade1 < grade2
                        
                    }
                }
            }
 //////////////////////////
        }
    }
  */
    static func MaxScore() -> String? {
        if let data = UserDefaults.standard.data(forKey: "grades"), let grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            let result = grade.sorted(by: {$0.score > $1.score})
            print("score: ")
            print(result)
            return result[0].score
        }
        else {
            return nil
        }
    }
    
    static func MaxLevel() -> String? {
        if let data = UserDefaults.standard.data(forKey: "grades"), let grade = try? PropertyListDecoder().decode([Grade].self, from: data) {
            let result = grade.sorted(by: {$0.score > $1.score})
            print("level: ")
            print(result)
            return result[0].level
        }
        else {
            return nil
        }
    }
        
}
