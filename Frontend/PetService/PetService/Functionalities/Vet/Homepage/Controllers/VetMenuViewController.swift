//
//  MenuViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol MenuItemSelectedProtocol: class {
    func itemSelected(row: Int)
}

class VetMenuViewController: UITableViewController {
    var delegate: MenuItemSelectedProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true) {
            if(indexPath.section == 0){
                self.delegate?.itemSelected(row: indexPath.row)
            } else {
                self.delegate?.itemSelected(row: 10)
            }
        }
    }

}
