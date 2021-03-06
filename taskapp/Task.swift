//
//  Task.swift
//  
//
//  Created by 藤田 和樹 on 2017/04/24.
//
//

import RealmSwift

class Task: Object {
// 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    // タイトル
    dynamic var title = ""
    
    // 内容
    dynamic var contents = ""
    
    //カテゴリー
    dynamic var  category = ""
    
    /// 日時
     dynamic var date = NSDate()
    
    
    /**
     id をプライマリーキーとして設定
     */
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
