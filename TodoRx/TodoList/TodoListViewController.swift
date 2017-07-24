//
//  TodoListViewController.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

private let reuseIdentifier = "TodoListTableViewCell"

class TodoListViewController: UIViewController {

    // MARK: presenter

    var presenter: TodoListPresenterProtocol!
    
    // MARK: boilerplate

    private let didTapRowSubject = PublishSubject<String>()
    private let didTapCreateTodoSubject = PublishSubject<Void>()

    // MARK: output

    let didTapRow: Observable<String>
    let didTapCreateTodo: Observable<Void>

    // MARK: ui elements

    @IBOutlet private weak var tableView: UITableView!

    // MARK: private

    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, TodoListRowModel>>()

    // MARK: init

    init() {
        didTapRow = didTapRowSubject.asObservable()
        didTapCreateTodo = didTapCreateTodoSubject.asObservable()
        super.init(nibName: "TodoListViewController", bundle: Bundle(for: TodoListViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: view lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Todo List"

        let createButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = createButton

        createButton.rx.tap
            .subscribe(didTapCreateTodoSubject)
            .disposed(by: disposeBag)

        dataSource.configureCell = { [unowned self] (ds, tv, ip, item) in
            return self.configureCell(dataSource: ds, tableView: tv, indexPath: ip, item: item)
        }

        dataSource.titleForHeaderInSection = { (ds, index) in
            ds[index].model
        }

        tableView.register(UINib(nibName: reuseIdentifier, bundle: Bundle(for: TodoListTableViewCell.self)),
                           forCellReuseIdentifier: reuseIdentifier)

        bindToPresenter()
    }

    // MARK: - binding

    private func bindToPresenter() {
        presenter.todoItems
            .map { sections in
                sections
                    .map { section in
                        AnimatableSectionModel(model: section.sectionType.displayText, items: section.rows)
                    }
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    private func configureCell(
            dataSource: TableViewSectionedDataSource<AnimatableSectionModel<String, TodoListRowModel>>,
            tableView: UITableView,
            indexPath: IndexPath,
            item: TodoListRowModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TodoListTableViewCell
        cell.textLabel?.text = item.name
        return cell
    }
}
