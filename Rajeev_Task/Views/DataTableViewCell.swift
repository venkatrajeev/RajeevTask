//
//  DataTableViewCell.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/20/18.
//  Copyright © 2018 Gemini. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var descriptionLabel:UILabel!
    @IBOutlet var picture:UIImageView!
    @IBOutlet var cellBackgroundView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        HelperClass.updateLayer(onView: cellBackgroundView, borderColor: UIColor.clear, borderWidth: 0, cornerRadious: 4)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
