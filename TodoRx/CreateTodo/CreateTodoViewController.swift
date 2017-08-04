//
//  CreateTodoViewController.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateTodoViewController: UIViewController {

    // MARK: boilerplate

    private let nameSubject = PublishSubject<String>()
    private let prioritySubject = PublishSubject<TodoPriority>()
    private let didTapSaveSubject = PublishSubject<Void>()
    private let didTapCancelSubject = PublishSubject<Void>()

    // MARK: output

    let name: Observable<String>
    let priority: Observable<TodoPriority>
    let didTapSave: Observable<Void>
    let didTapCancel: Observable<Void>

    // MARK: input

    var presenter: CreateTodoPresenterProtocol!

    // MARK: ui elements

    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var priorityControl: UISegmentedControl!

    // MARK: private

    private let disposeBag = DisposeBag()

    // MARK: init

    init() {
        name = nameSubject.asObservable()
        priority = prioritySubject.asObservable()
        didTapSave = didTapSaveSubject.asObservable()
        didTapCancel = didTapCancelSubject.asObservable()
        super.init(nibName: "CreateTodoViewController", bundle: Bundle(for: CreateTodoViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: view lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
        // handle input

        presenter.isSaveButtonEnabled
            .debug("isSaveButtonEnabled")
            .drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)

        nameField.text = presenter.initialName
        priorityControl.selectedSegmentIndex = presenter.initialPriority.rawValue
        title = presenter.title

        // produce output

        nameField.rx.text
            .orEmpty
            .skip(1)
            .subscribe(nameSubject)
            .disposed(by: disposeBag)

        priorityControl.rx.value
            .skip(1)
            .map {
                switch $0 {
                case 0: return .low
                case 1: return .medium
                case 2: return .high
                default:
                    assert(false, "invalid value: \($0)")
                    return .medium
                }
            }
            .subscribe(prioritySubject)
            .disposed(by: disposeBag)

        cancelButton.rx.tap
            .subscribe(didTapCancelSubject)
            .disposed(by: disposeBag)

        saveButton.rx.tap
            .subscribe(didTapSaveSubject)
            .disposed(by: disposeBag)
    }

}
