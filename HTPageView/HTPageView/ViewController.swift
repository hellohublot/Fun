//
//  ViewController.swift
//  HTPageView
//
//  Created by hublot on 2018/12/14.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailController = DetailViewController()
		detailController.separatorType = indexPath.row
		navigationController?.pushViewController(detailController, animated: true)
	}

}

