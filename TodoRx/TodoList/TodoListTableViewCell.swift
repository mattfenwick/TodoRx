//
//  TodoListTableViewCell.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit
import RxSwift

class TodoListTableViewCell: UITableViewCell {

    private (set) var disposeBag = DisposeBag()

    @IBOutlet private (set) weak var nameLabel: UILabel!
    @IBOutlet private (set) weak var isFinishedSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
