//
//  MyCell.swift
//  Swift-CalculateCellHight
//
//  Created by huchunyuan on 15/12/6.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 作者
    @IBOutlet weak var writer: UILabel!
   
    /// 三行评论
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
