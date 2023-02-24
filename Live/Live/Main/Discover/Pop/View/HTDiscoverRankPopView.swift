//
//  HTDiscoverRankPopView.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverRankPopView: UIView {
    
    typealias HTDiscoverRankPopSelected = ((_: [Any], _: Int, _: Any) -> Void)
    
    var rankPopSelected: HTDiscoverRankPopSelected?

    lazy var triangleView: UIView = {
        let view = UIView.init(frame: CGRect.zero)
        view.layer.insertSublayer(triangleLayer, at: 0)
        return view
    }()
    
    lazy var triangleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.separatorColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        return tableView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let triangleViewBounds = triangleView.bounds
        triangleLayer.frame = triangleViewBounds
        
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: CGPoint.init(x: 0, y: triangleViewBounds.size.height))
        bezierPath.addLine(to: CGPoint.init(x: triangleViewBounds.size.width / 2.0, y: 0))
        bezierPath.addLine(to: CGPoint.init(x: triangleViewBounds.size.width, y: triangleViewBounds.size.height))
        bezierPath.close()
        triangleLayer.path = bezierPath.cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        addSubview(triangleView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0))
        }
        triangleView.snp.makeConstraints { (maker) in
            maker.right.equalTo(-20)
            maker.bottom.equalTo(tableView.snp.top)
            maker.top.equalTo(0)
            maker.width.equalTo(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModelArray(_ modelArray: [HTDiscoverRankPopModel]) {
        tableView.setCellModelArray(modelArray, proxy: self)
        tableView.reloadData()
    }
    
}

extension HTDiscoverRankPopView: TableViewThrough {
    
    func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
        return HTDiscoverRankPopCell.self
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
        return tableView.bounds.size.height / CGFloat(tableView.cellModelArray().count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let modelArray = tableView.cellModelArray() as? [HTDiscoverRankPopModel] ?? [HTDiscoverRankPopModel]()
        for model in modelArray {
            model.selected = false
        }
        let selectedModel = modelArray[indexPath.row]
        selectedModel.selected = true
        rankPopSelected?(tableView.cellModelArray(), indexPath.row, selectedModel)
    }
    
}
