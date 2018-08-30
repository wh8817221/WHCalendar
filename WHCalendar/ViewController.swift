//
//  ViewController.swift
//  WHCalendar
//
//  Created by 王浩 on 2018/8/28.
//  Copyright © 2018年 haoge. All rights reserved.
//

import UIKit
import DynamicColor
class ViewController: UIViewController {

    fileprivate var calendar: WHCalendar!
    fileprivate var dateButton: UIButton!
    fileprivate var defaultDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        dateButton = UIButton(type: .custom)
        dateButton.setTitle("设置日期", for: .normal)
        dateButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(dateButton)
        dateButton.addTarget(self, action: #selector(setDate), for: .touchUpInside)
        dateButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.view)
        }
    }

    @objc fileprivate func setDate() {
        calendar = WHCalendar()
        calendar.dafaultDate = self.defaultDate
        calendar.animationType = .center
//        calendar.model = CalendarModel()
        calendar.callback = { [unowned self](value) in
            if let date = value as? String {
                self.defaultDate = dateFromFormat(date: date)
                self.dateButton.setTitle("设置日期: \(date)", for: .normal)
            }
        }
        calendar.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

