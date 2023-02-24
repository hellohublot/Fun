//
//  HTDiscoverHomeDetailRichPageModel.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverHomeDetailRichPageType: String {
    case day = "richDay"
    case week = "richWeek"
    case month = "richMonth"
    case all = "richAll"
}

class HTDiscoverHomeDetailRichPageModel: NSObject, HTPageModelAble {
    
    var title: String?
    var type: HTDiscoverHomeDetailRichPageType?
    var text: String?
    var controllerClass: UIViewController.Type?
    var image: String?
    var selectedImage: String?
    var selected: Bool?
    
    var controller: UIViewController?
    
    class func packModelArray() -> [HTDiscoverHomeDetailRichPageModel] {
        let titleKey = "titleKey"
        let typeKey = "typeKey"
        let textKey = "textKey"
        let controllerClassKey = "controllerClassKey"
        let imageKey = "imageKey"
        let selectedImageKey = "selectedImageKey"
        let selectedKey = "selectedKey"
        let keyValueArray = [
            [titleKey: "日榜", typeKey: HTDiscoverHomeDetailRichPageType.day, textKey: "", controllerClassKey: HTDiscoverHomeDetailRichContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
            [titleKey: "周榜", typeKey: HTDiscoverHomeDetailRichPageType.week, textKey: "", controllerClassKey: HTDiscoverHomeDetailRichContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
            [titleKey: "月榜", typeKey: HTDiscoverHomeDetailRichPageType.month, textKey: "", controllerClassKey: HTDiscoverHomeDetailRichContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
            [titleKey: "超级榜", typeKey: HTDiscoverHomeDetailRichPageType.all, textKey: "", controllerClassKey: HTDiscoverHomeDetailRichContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
        ]
        let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeDetailRichPageModel in
            let model = HTDiscoverHomeDetailRichPageModel()
            model.title = dictionary[titleKey] as? String
            model.type = dictionary[typeKey] as? HTDiscoverHomeDetailRichPageType
            model.text = dictionary[textKey] as? String
            model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
            model.image = dictionary[imageKey] as? String
            model.selected = dictionary[selectedKey] as? Bool
            model.selectedImage = dictionary[selectedImageKey] as? String
            model.controller = model.controllerClass?.init()
            return model
        }
        return modelArray
    }
}
