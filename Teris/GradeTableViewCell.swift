//
//  GradeTableViewCell.swift
//  Teris
//
//  Created by User16 on 2019/1/12.
//  Copyright © 2019 User21. All rights reserved.
//

import UIKit

class GradeTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var record_level: UILabel!
    @IBOutlet weak var record_score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
