//
//  HTDiscoverRankPopModel.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverRankPopListType {
    case `default`
    case pk
    case charm
    case home
}

enum HTDiscoverRankPopType: String {
    case day = "1"
    case week = "2"
    case month = "3"
    case all = "4"
    case homeday = "day"
    case homeweek = "week"
    case homemonth = "month"
    case homeall = "all"
}

class HTDiscoverRankPopModel: NSObject {
    
    var title: String?
    var type: HTDiscoverRankPopType?
    var text: String?
    var controllerClass: UIViewController.Type?
    var image: String?
    var selectedImage: String?
    var selected: Bool?
    
    class func packModelArray(_ listType: HTDiscoverRankPopListType?) -> [HTDiscoverRankPopModel] {
        let titleKey = "titleKey"
        let typeKey = "typeKey"
        let textKey = "textKey"
        let controllerClassKey = "controllerClassKey"
        let imageKey = "imageKey"
        let selectedImageKey = "selectedImageKey"
        let selectedKey = "selectedKey"
        var keyValueArray = [[String: Any]]()
        switch listType {
        case .default?:
            keyValueArray.append(contentsOf: [
                [titleKey: "日榜", typeKey: HTDiscoverRankPopType.day, textKey: "", controllerClassKey: UIViewController.self, imageKey: "4747621de84b15b51b8dde4f07640974", selectedImageKey: "", selectedKey: true],
                [titleKey: "周榜", typeKey: HTDiscoverRankPopType.week, textKey: "", controllerClassKey: UIViewController.self, imageKey: "fdf945330157a8aed64331058db986b5", selectedImageKey: "", selectedKey: false],
                [titleKey: "月榜", typeKey: HTDiscoverRankPopType.month, textKey: "", controllerClassKey: UIViewController.self, imageKey: "2198ede0df443361a639495c4e4a1d76", selectedImageKey: "", selectedKey: false],
                [titleKey: "总榜", typeKey: HTDiscoverRankPopType.all, textKey: "", controllerClassKey: UIViewController.self, imageKey: "9cf90489b2b7beca9e3e3174d6a55165", selectedImageKey: "", selectedKey: false],
            ])
        case .pk?:
            keyValueArray.append(contentsOf: [
                [titleKey: "上周", typeKey: HTDiscoverRankPopType.week, textKey: "", controllerClassKey: UIViewController.self, imageKey: "fdf945330157a8aed64331058db986b5", selectedImageKey: "", selectedKey: true],
                [titleKey: "本周", typeKey: HTDiscoverRankPopType.all, textKey: "", controllerClassKey: UIViewController.self, imageKey: "fdf945330157a8aed64331058db986b5", selectedImageKey: "", selectedKey: false],
            ])
        case .charm?:
            keyValueArray.append(contentsOf: [
                [titleKey: "月榜", typeKey: HTDiscoverRankPopType.month, textKey: "", controllerClassKey: UIViewController.self, imageKey: "2198ede0df443361a639495c4e4a1d76", selectedImageKey: "", selectedKey: true],
                [titleKey: "总榜", typeKey: HTDiscoverRankPopType.all, textKey: "", controllerClassKey: UIViewController.self, imageKey: "9cf90489b2b7beca9e3e3174d6a55165", selectedImageKey: "", selectedKey: false],
            ])
        case .home?:
            keyValueArray.append(contentsOf: [
                [titleKey: "日榜", typeKey: HTDiscoverRankPopType.homeday, textKey: "", controllerClassKey: UIViewController.self, imageKey: "4747621de84b15b51b8dde4f07640974", selectedImageKey: "", selectedKey: true],
                [titleKey: "周榜", typeKey: HTDiscoverRankPopType.homeweek, textKey: "", controllerClassKey: UIViewController.self, imageKey: "fdf945330157a8aed64331058db986b5", selectedImageKey: "", selectedKey: false],
                [titleKey: "月榜", typeKey: HTDiscoverRankPopType.homemonth, textKey: "", controllerClassKey: UIViewController.self, imageKey: "2198ede0df443361a639495c4e4a1d76", selectedImageKey: "", selectedKey: false],
                [titleKey: "总榜", typeKey: HTDiscoverRankPopType.homeall, textKey: "", controllerClassKey: UIViewController.self, imageKey: "9cf90489b2b7beca9e3e3174d6a55165", selectedImageKey: "", selectedKey: false],
            ])
        default:
            break
        }
        let modelArray = keyValueArray.map { dictionary -> HTDiscoverRankPopModel in
            let model = HTDiscoverRankPopModel()
            model.title = dictionary[titleKey] as? String
            model.type = dictionary[typeKey] as? HTDiscoverRankPopType
            model.text = dictionary[textKey] as? String
            model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
            model.image = dictionary[imageKey] as? String
            model.selected = dictionary[selectedKey] as? Bool
            model.selectedImage = dictionary[selectedImageKey] as? String
            return model
        }
        return modelArray
    }
    
    class func findSelectedModel(_ modelArray: [HTDiscoverRankPopModel]?) -> HTDiscoverRankPopModel? {
        for model in (modelArray ?? [HTDiscoverRankPopModel]()) {
            if model.selected == true {
                return model
            }
        }
        return nil
    }
    
}
