//
//  HTDiscoverHomeDetailGloryModel.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverHomeDetailGloryType {
    case `default`
}

class HTDiscoverHomeDetailGloryModel: NSObject {
    
    var title: String?
    var type: HTDiscoverHomeDetailGloryType?
    var text: String?
    var controllerClass: UIViewController.Type?
    var image: String?
    var selectedImage: String?
    var selected: Bool?
    
    class func packModelArray(_ value: [String: Any]) -> [HTDiscoverHomeDetailGloryModel] {
        let titleKey = "titleKey"
        let typeKey = "typeKey"
        let textKey = "textKey"
        let controllerClassKey = "controllerClassKey"
        let imageKey = "imageKey"
        let selectedImageKey = "selectedImageKey"
        let selectedKey = "selectedKey"
        let keyValueArray = [
            [titleKey: "消费榜排名: ", typeKey: HTDiscoverHomeDetailGloryType.default, textKey: String((value["consume"] as? Int) ?? 0), controllerClassKey: UIViewController.self, imageKey: "2b76118eed7e9807c7a7dc974667a4bb", selectedImageKey: "", selectedKey: false],
            [titleKey: "富豪榜排名: ", typeKey: HTDiscoverHomeDetailGloryType.default, textKey: String((value["richNums"] as? Int) ?? 0), controllerClassKey: UIViewController.self, imageKey: "36abb580be50a34ff89450eccfd813d5", selectedImageKey: "", selectedKey: false],
            [titleKey: "主播榜排名: ", typeKey: HTDiscoverHomeDetailGloryType.default, textKey: String((value["anchorNums"] as? Int) ?? 0), controllerClassKey: UIViewController.self, imageKey: "e1ff7e53e77836e0476b7b2a88187aaf", selectedImageKey: "", selectedKey: false],
        ]
        let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeDetailGloryModel in
            let model = HTDiscoverHomeDetailGloryModel()
            model.title = dictionary[titleKey] as? String
            model.type = dictionary[typeKey] as? HTDiscoverHomeDetailGloryType
            model.text = dictionary[textKey] as? String
            model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
            model.image = dictionary[imageKey] as? String
            model.selected = dictionary[selectedKey] as? Bool
            model.selectedImage = dictionary[selectedImageKey] as? String
            return model
        }
        return modelArray
    }
}
