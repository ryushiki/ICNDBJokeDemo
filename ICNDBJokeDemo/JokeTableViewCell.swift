//
//  JokeTableViewCell.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/2.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import UIKit

class JokeTableViewCell: UITableViewCell {

    @IBOutlet weak var jokeContent: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
