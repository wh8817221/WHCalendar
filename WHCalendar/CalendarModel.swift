//
//  CalendarModel.swift
//  WHCalendar
//
//  Created by 王浩 on 2018/8/29.
//  Copyright © 2018年 haoge. All rights reserved.
//

import UIKit
let KMainColor = UIColor(red: 0, green: 139/255, blue: 125/255, alpha: 1.0)
let KbackColor = UIColor(red: 173/255, green: 212/255, blue: 208/255, alpha: 1.0)
class CalendarModel: NSObject {
    /**左侧视图背景色*/
    var leftViewBackgroundColor: UIColor = KMainColor
    /**右侧视图背景色*/
    var rightViewBackgroundColor: UIColor = UIColor(hexString: "#efeff4")
    /**星期视图背景色*/
    var weekBackgroundColor: UIColor = .orange
    /**星期字体颜色*/
    var weekLabelTextColor: UIColor = .white
    /**星期字体大小*/
    var weekLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 15 : 20)
    /**左侧年字体颜色*/
    var yearLabelTextColor: UIColor = KbackColor
    /**左侧年字体大小*/
    var yearLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 17 : 24)
    /**左侧月字体颜色*/
    var monthLabelTextColor: UIColor = .white
    /**左侧月字体大小*/
    var monthLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 17 : 24)
    /**左侧天字体颜色*/
    var dayLabelTextColor: UIColor = .white
    /**左侧天字体大小*/
    var dayLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 35 : 44)
    /**选择按钮字体颜色*/
    var optionButtonTextColor: UIColor = .black
    /**选择按钮字体大小*/
    var optionButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
    /**今天字体大小*/
    var todayButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
    /**今天字体颜色*/
    var todayButtonTextColor: UIColor = .black
    /**星期标签的字体大小*/
    var rightWeekLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
    /**星期标签的字体颜色*/
    var rightWeekLabelTextColor: UIColor = .black
    /**天按钮默认字体大小*/
    var dayButtonDefaultFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
    /**天按钮默认字体颜色*/
    var dayButtonDefaultTextColor: UIColor = .black
    /**天按钮默认背景颜色*/
    var dayButtonDefaultBackgroundColor: UIColor = .white
    /**天按钮选中字体大小*/
    var dayButtonSelectorFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
    /**天按钮选中字体颜色*/
    var dayButtonSelectorTextColor: UIColor = KMainColor
    /**天按钮选中背景颜色*/
    var dayButtonSelectorBackgroundColor: UIColor = KbackColor
    /**取消字体颜色*/
    var cancelButtonTextColor: UIColor = KMainColor
    /**取消字体大小*/
    var cancelButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
    /**确定字体颜色*/
    var sureButtonTextColor: UIColor = KMainColor
    /**确定字体大小*/
    var sureButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
}
