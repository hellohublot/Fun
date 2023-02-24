//
//  HTDiscoverHomeDetailRichContentController.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverHomeDetailRichContentController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
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
        
    }
    
    func initInterface() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    func reloadModelArrayWithType(_ homeIdString: String, _ type: HTDiscoverHomeDetailRichPageType?) {
        tableView.setRefreshingBlock(Refresher.circle) { [weak self] (_, _) in
            Request.list.homeDetailRich(homeIdString, { (result) in
                guard let value = result.value as? [String: Any] else {
                    self?.tableView.endRefreshWithOnlyOnePage(modelCount: PlaceholderState.errorNetwork.rawValue)
                    return
                }
                let modelArray = HTMineUserInfoModel.mj_objectArray(withKeyValuesArray: value[type?.rawValue ?? ""]) as? [HTMineUserInfoModel] ?? [HTMineUserInfoModel]()
                self?.tableView.setCellModelArray(modelArray, proxy: self)
                self?.tableView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
                self?.tableView.reloadData()
            })
        }
        tableView.respondHeaderRefresh()
    }
    
    /*-------------------------------------/ controller override /-----------------------------------*/
    
    
}

extension HTDiscoverHomeDetailRichContentController: TableViewThrough {
    
    func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
        return HTDiscoverHomeDetailRichContentCell.self
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
        return 70
    }
    
}
