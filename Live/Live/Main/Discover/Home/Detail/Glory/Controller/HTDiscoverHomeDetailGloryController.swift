//
//  HTDiscoverHomeDetailGloryController.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverHomeDetailGloryController: UIViewController {

    var homeIdString = ""
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.placeholderProvider = Placeholder.default
        return tableView
    }()
    
    /*-------------------------------------/ init /-----------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataSource()
        initInterface()
    }
    
    func initDataSource () {
        tableView.setRefreshingBlock(Refresher.circle) { [weak self] (_, _) in
            Request.list.homeDetailGlory(self?.homeIdString ?? "", { (result) in
                guard let value = result.value as? [String: Any] else {
                    self?.tableView.endRefreshWithOnlyOnePage(modelCount: PlaceholderState.errorNetwork.rawValue)
                    return
                }
                let modelArray = HTDiscoverHomeDetailGloryModel.packModelArray(value)
                self?.tableView.setCellModelArray(modelArray, proxy: self)
                self?.tableView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
                self?.tableView.reloadData()
            })
        }
        tableView.respondHeaderRefresh()
    }
    
    func initInterface() {
        navigationItem.title = "家族荣耀"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    /*-------------------------------------/ controller override /-----------------------------------*/
    
    

}

extension HTDiscoverHomeDetailGloryController: TableViewThrough {
    
    func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
        return HTDiscoverHomeDetailGloryCell.self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reuseViewNumberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reuseView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
}
