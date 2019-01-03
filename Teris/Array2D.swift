//
//  Array2D.swift
//  Teris
//
//  Created by User21 on 2018/12/13.
//  Copyright © 2018 User21. All rights reserved.

//背景
class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(repeating: nil, count: rows * columns) // repeating:nil表示所有初始化的值都是一樣的，count表示數組的大小
    }
    
    /* 定義二維陣列的查找符號 */
    subscript(column: Int, row: Int) -> T? { /* 輸入兩個參數column, row ， 經過函式的計算後返回一個T類型的值 */
        get {
            return array[(row * columns) + column]
        }
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }
}
