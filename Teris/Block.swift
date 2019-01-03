//
//  Block.swift
//  Teris
//
//  Created by User21 on 2018/12/13.
//  Copyright © 2018 User21. All rights reserved.
//
import SpriteKit

let NumberOfColors: UInt32 = 6 //可以顯示的顏色種類

enum BlockColor: Int, CustomStringConvertible {
    
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    // computed property
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }
    
    // computed property
    var description: String {
        return self.spriteName
    }
    
    // 隨機產生顏色
    static func random() -> BlockColor {
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}


// Hashable協議將允許Block存儲在Array2D中
class Block: Hashable, CustomStringConvertible {
    
    // Constants
    let color: BlockColor
    
    // Properties
    var column: Int //決定block在螢幕上的位置
    var row: Int //決定block在螢幕上的位置
    var sprite: SKSpriteNode? //SKSpriteNode將會在GameScene對每一個block著色及動畫的時候將其描繪在螢幕上
    
    //當調用block.spriteName的時候，其實調用的是block.color.spriteName
    var spriteName: String {
        return color.spriteName
    }
    
    //定義了Hashable協議需要的内容，定義了當前block的行數和列數的亦或值以确保它們都是獨一為二的，這樣才能被hash出来
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column: Int, row: Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
    
}

/* 自定義符號'＝' */
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
} // 如果這個block的row，column和color都一樣，就回傳ture
