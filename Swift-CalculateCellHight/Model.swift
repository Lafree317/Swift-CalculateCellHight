//
//  Model.swift
//  Swift-CalculateCellHight
//
//  Created by huchunyuan on 15/12/6.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit

class Model: NSObject {
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        return;
    }
    // 传入字符串计算行数
    func PassStringReturnIndex(str:String)->Int {
        // 比较值
        let rangeStr = "\n"
        // 比较
        let range = str.rangeOfString(rangeStr)
        // 如果有结果
        if range != nil {
            // 行数+1
            line++
            // 从比较结尾进行切割字符串
            let str2 = str.substringFromIndex(range!.endIndex)
            // 递归调用函数
            PassStringReturnIndex(str2)
        }
        return line
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        // 当赋值Comment时计算行高
        if key == "comment" {
            // plist里写的\n都为\\n 这里替换成\n
            comment = (value as!String).stringByReplacingOccurrencesOfString("\\n", withString: "\n")
            // 调用计算行高函数
            line = PassStringReturnIndex(comment)
        }
    }
    // 属性
    var title:String = ""
    var writer:String = ""
    var comment:String = ""
    var line:Int = 0
}
