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
    @IBOutlet private (set) weak var dateLabel: UILabel!
    @IBOutlet private (set) weak var isFinishedButton: UIButton!

    var isFinished: Bool = false {
        didSet {
            // TODO maybe some other style changes?
            // also, it's ambiguous what the button text means -- does it mean
            //   "this is done", or "if you tap on this, it *will* be done" ?
            let title = isFinished ? "Done" : "To do!"
            isFinishedButton.setTitle(title, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
