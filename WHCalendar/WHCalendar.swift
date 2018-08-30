//
//  WHCalendar.swift
//  WHCalendar
//
//  Created by 王浩 on 2018/8/28.
//  Copyright © 2018年 haoge. All rights reserved.
//

import UIKit
import SnapKit
//回调
typealias ObjectCallback = (_ value: Any) -> Void

let kScreenWidth: CGFloat = UIScreen.main.bounds.width
let kScreenHeight: CGFloat = UIScreen.main.bounds.height
let spaceMargin: CGFloat = 5.0
let KShowYearsCount: Int = 100
let KTipWidth: CGFloat = kScreenWidth/5
let KCol: Int = 7
let KBtnW: CGFloat = (kScreenWidth-KTipWidth-2*spaceMargin)/CGFloat(KCol)
let KMaxCount: Int = 37
let KBtnTag: Int = 100
//适配iPhoneX
var IS_IPHONE_X: Bool {
    return UIScreen.instancesRespond(to: #selector(getter: UIDynamicItem.bounds)) ? CGSize(width: 375, height: 812).equalTo(UIScreen.main.bounds.size) : false
}

let navHeight:CGFloat = IS_IPHONE_X ? 24 : 0
let tabHeight:CGFloat = IS_IPHONE_X ? 34 : 0

class WHCalendar: UIView {
    enum AnimationType {
        case top
        case bottom
        case center
    }
    var callback: ObjectCallback?
    //默认底部出现
    var animationType = AnimationType.bottom
    var dafaultDate: Date = Date()
    var model = CalendarModel()
    fileprivate var weekArray: [String]?
    fileprivate var timeArray: [[String]]?
    fileprivate var yearArray: [String]?
    fileprivate var monthArray: [String]?
    fileprivate var calendarView: UIView!
    fileprivate var weekLabel: UILabel!
    fileprivate var yearLabel: UILabel!
    fileprivate var monthLabel: UILabel!
    fileprivate var dayLabel: UILabel!
    fileprivate var year: Int?
    fileprivate var month: Int?
    fileprivate var day: Int?
    fileprivate var currentYear: Int?
    fileprivate var currentMonth: Int?
    fileprivate var currentDay: Int?
    fileprivate var selectYear: Int?
    fileprivate var selectMonth: Int?
    
    fileprivate var yearBtn: WHOpthionButton!
    fileprivate var monthBtn: WHOpthionButton!
    fileprivate var yearBtnW: CGFloat = 70.0
    fileprivate var monthbtnW: CGFloat = 70.0
    fileprivate var todayBtnW: CGFloat = 70.0
    fileprivate var control: UIControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-初始化设置
    fileprivate func setDefaultInfo(date: Date) {
        let components = Calendar.current
        year = components.component(.year, from: date)
        month = components.component(.month, from: date)
        day = components.component(.day, from: date)
        
        selectYear = year
        selectMonth = month
        self.getDatasouce()
    }
    
    //MARK:-获取当前时间
    fileprivate func getCurrentDate() {
        let components = Calendar.current
        currentYear = components.component(.year, from: Date())
        currentMonth = components.component(.month, from: Date())
        currentDay = components.component(.day, from: Date())
        self.setDefaultInfo(date: dafaultDate)
    }
    
    //MARK:-获取数据源
    fileprivate func getDatasouce() {
        weekArray = ["日", "一", "二", "三", "四", "五", "六"]
        timeArray = [["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"], ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]]
        let firstYear = year! - KShowYearsCount/2
        var yearArr = [String]()
        for i in 0..<KShowYearsCount {
            yearArr.append("\(firstYear+i)")
        }
        yearArray = yearArr
        monthArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    }
    
    //MARK:-创建控件
    fileprivate func creatControl() {
        //左侧视图
        let letfView = UIView()
        letfView.backgroundColor = model.leftViewBackgroundColor
        self.addSubview(letfView)
        letfView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.width.equalTo(KTipWidth)
            make.height.equalTo(self.frame.height)
        }
        
        //星期标签
        weekLabel = UILabel()
        weekLabel.backgroundColor = model.weekBackgroundColor
        weekLabel.textColor = model.weekLabelTextColor
        weekLabel.textAlignment = .center
        weekLabel.font = model.weekLabelFont
        letfView.addSubview(weekLabel)
        weekLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(letfView)
            make.height.equalTo(KBtnW)
        }
        //年份标签
        yearLabel = UILabel()
        yearLabel.textColor = model.yearLabelTextColor
        yearLabel.textAlignment = .center
        yearLabel.font = model.yearLabelFont
        letfView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weekLabel.snp.bottom).offset(20)
            make.left.right.equalTo(letfView)
        }
        //月份标签
        monthLabel = UILabel()
        monthLabel.textColor = model.monthLabelTextColor
        monthLabel.textAlignment = .center
        monthLabel.font = model.monthLabelFont
        letfView.addSubview(monthLabel)
        monthLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(letfView)
            make.top.equalTo(yearLabel.snp.bottom)
        }
        //日期标签
        dayLabel = UILabel()
        dayLabel.textColor = model.dayLabelTextColor
        dayLabel.textAlignment = .center
        dayLabel.font = model.dayLabelFont
        letfView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(letfView)
            make.centerY.equalTo(letfView.snp.centerY)
        }
        
        yearBtn = WHOpthionButton(frame: CGRect.zero, row: KShowYearsCount/2, array: yearArray, model: self.model)
        yearBtn.callBack = { [unowned self](value) in
            if let btn = value as? WHOpthionButton {
                if (btn.title?.count)! > 2 {
                    self.year = Int(btn.title!)
                    self.yearBtn.title = "\(self.year!)年"
                } else {
                    self.month = Int(btn.title!)
                    self.monthBtn.title = "\(self.month!)月"
                }
            }
            self.reloadData()
        }
        
        self.addSubview(yearBtn)
        yearBtn.snp.makeConstraints { (make) in
            make.left.equalTo(letfView.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(KBtnW)
            make.width.equalTo((self.frame.width-KTipWidth)*1.5/5)
        }
        
        let containerW = (self.frame.width-KTipWidth)*2/5
        let container = UIView()
        self.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.left.equalTo(yearBtn.snp.right)
            make.top.equalTo(yearBtn.snp.top)
            make.height.equalTo(KBtnW)
            make.width.equalTo(containerW)
        }

        let preMonthBtn = UIButton(type: .custom)
        preMonthBtn.setImage(UIImage(named:"left"), for: .normal)
        preMonthBtn.addTarget(self, action: #selector(preBtnOnClick(_:)), for: .touchUpInside)
        container.addSubview(preMonthBtn)
        preMonthBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(container)
            make.width.equalTo(containerW/4)
        }
        
        monthBtn = WHOpthionButton(frame: CGRect.zero, row: month!-1, array: monthArray, model: self.model)
        monthBtn.callBack = { [unowned self](value) in
            if let btn = value as? WHOpthionButton {
                if (btn.title?.count)! > 2 {
                    self.year = Int(btn.title!)
                    self.yearBtn.title = "\(self.year!)年"
                } else {
                    self.month = Int(btn.title!)
                    self.monthBtn.title = "\(self.month!)月"
                }
            }
            self.reloadData()
        }
        
        container.addSubview(monthBtn)
        monthBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(container.snp.centerX)
            make.top.equalTo(preMonthBtn.snp.top)
            make.height.equalTo(preMonthBtn.snp.height)
            make.width.equalTo(containerW/2)
        }
        
        let nextMonthBtn = UIButton(type: .custom)
        nextMonthBtn.setImage(UIImage(named:"right"), for: .normal)
        nextMonthBtn.addTarget(self, action: #selector(nextBtnOnClick(_:)), for: .touchUpInside)
        container.addSubview(nextMonthBtn)
        nextMonthBtn.snp.makeConstraints { (make) in
            make.right.equalTo(container.snp.right)
            make.top.equalTo(preMonthBtn.snp.top)
            make.height.width.equalTo(preMonthBtn)
        }
        
        //返回今天
        let backTodayBtn = UIButton(type: .custom)
        backTodayBtn.titleLabel?.font = model.todayButtonFont
        backTodayBtn.setTitleColor(model.todayButtonTextColor, for: .normal)
        backTodayBtn.setTitle("今天", for: .normal)
        backTodayBtn.addTarget(self, action: #selector(backTodayBtnOnClick(_:)), for: .touchUpInside)
        self.addSubview(backTodayBtn)
        backTodayBtn.snp.makeConstraints { (make) in
            make.top.equalTo(container.snp.top)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(container.snp.right)
            make.height.width.equalTo(yearBtn)
        }
        
        var tempWeekLabel: UILabel?
        //星期标签
        for i in 0..<(weekArray?.count)! {
            let week = UILabel()
            week.font = model.rightWeekLabelFont
            week.textColor = model.rightWeekLabelTextColor
            week.textAlignment = .center
            week.text = (weekArray?[i])!
            self.addSubview(week)
            week.snp.makeConstraints { (make) in
                if i == (weekArray?.count)! {
                    make.right.equalTo(self.snp.right)
                    make.left.equalTo((tempWeekLabel?.snp.left)!)
                    make.top.equalTo(backTodayBtn.snp.bottom)
                    make.height.equalTo(KBtnW)
                    make.width.equalTo(KBtnW)
                } else {
                    if let tempWeekLabel = tempWeekLabel {
                        make.left.equalTo(tempWeekLabel.snp.right)
                    } else {
                        make.left.equalTo(letfView.snp.right)
                    }
                    make.width.equalTo(KBtnW)
                    make.top.equalTo(backTodayBtn.snp.bottom)
                    make.height.equalTo(KBtnW)
                }
            }
            tempWeekLabel = week
        }
        
        //MARK:-日历核心视图
        calendarView = UIView()
        self.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.left.equalTo(letfView.snp.right)
            make.top.equalTo((tempWeekLabel?.snp.bottom)!)
            make.height.equalTo(KBtnW*6)
            make.right.equalTo(self.snp.right)
        }
        //每一个日期用一个按钮去创建，当一个月的第一天是星期六并且有31天时为最多个数，5行零2个，共37个
        for i in 0...KMaxCount {
//            let margin: CGFloat = 2.0
            let btnX = CGFloat(i%KCol) * KBtnW
            let btnY = CGFloat(i/KCol) * KBtnW
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: btnX, y: btnY, width: KBtnW, height: KBtnW)
            btn.tag = i + KBtnTag
            btn.layer.cornerRadius = KBtnW/2
            btn.layer.masksToBounds = true
            btn.titleLabel?.font = model.dayButtonDefaultFont
            btn.setTitle("\(i + 1)", for: .normal)
            btn.setTitleColor(model.dayButtonDefaultTextColor, for: .normal)
            btn.setTitleColor(model.dayButtonSelectorTextColor, for: .selected)
            
            btn.setBackgroundImage(self.imageWithColor(color: model.dayButtonSelectorBackgroundColor), for: .highlighted)
            btn.setBackgroundImage(self.imageWithColor(color: model.dayButtonSelectorBackgroundColor), for: .selected)
            
            btn.addTarget(self, action: #selector(dateBtnOnClick(_:)), for: .touchUpInside)
            calendarView.addSubview(btn)
        }
        
        //确认按钮
        let sureBtn = UIButton(type: .custom)
        sureBtn.titleLabel?.font = model.sureButtonFont
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(model.sureButtonTextColor, for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnOnClick(_:)), for: .touchUpInside)
        self.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right)
            make.height.equalTo(KBtnW)
            make.width.equalTo(2*KBtnW)
            make.top.equalTo(calendarView.snp.bottom)
        }
        
        //取消按钮
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.titleLabel?.font = model.cancelButtonFont
        cancelBtn.setTitleColor(model.cancelButtonTextColor, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnOnClick(_:)), for: .touchUpInside)
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(sureBtn.snp.left)
            make.height.equalTo(KBtnW)
            make.width.equalTo(2*KBtnW)
            make.top.equalTo(calendarView.snp.bottom)
        }
    }

    //MARK:日期选择
    @objc fileprivate func dateBtnOnClick(_ sender: UIButton) {
        //记录选择了某年某月的一天 其他年月不显示选择的天
        selectYear = self.year
        selectMonth = self.month
        day = sender.tag - KBtnTag - (self.firstDayOfWeekInMonth()-2)
        let week = weekArray?[(sender.tag - KBtnTag)%7]
        weekLabel.text = "星期\(week ?? "")"
        dayLabel.text = "\(day ?? 0)"
        if sender.isSelected { return }
        for i in 0...KMaxCount {
            if let btn = self.calendarView.viewWithTag(i + KBtnTag) as? UIButton {
                btn.isSelected = false
            }
        }
        sender.isSelected = true
    }
    
    //MARK:取消
    @objc fileprivate func cancelBtnOnClick(_ sender: UIButton) {
        self.dismiss()
    }
    //MARK:确定按钮
    @objc fileprivate func sureBtnOnClick(_ sender: UIButton) {
        self.dismiss()
        let date = "\(year!)-\(month!)-\(day!)"
        self.callback?(date)
    }
    
    //MARK:-弹入视图
    func show() {
        //布局子控件
        let vc = UIApplication.shared.keyWindow
        control = UIControl(frame: UIScreen.main.bounds)
        control?.backgroundColor = UIColor(white: 0, alpha: 0.5)
        control?.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        vc?.addSubview(control!)
        vc?.addSubview(self)
        switch self.animationType {
        case .bottom:
            self.frame = CGRect(x: spaceMargin, y: kScreenHeight+tabHeight, width: kScreenWidth-2*spaceMargin, height: KBtnW*9)
        case .center:
            self.frame = CGRect(x: spaceMargin, y: (kScreenHeight - KBtnW*9)/2, width: kScreenWidth-2*spaceMargin, height: KBtnW*9)
        case .top:
            self.frame = CGRect(x: 0, y: -kScreenHeight, width: kScreenWidth, height: KBtnW*9)
        }
        self.layer.setValue(0, forKeyPath: "transform.scale")
        UIView.animate(withDuration: 0.3) {
            switch self.animationType {
            case .bottom:
                self.frame = CGRect(x: spaceMargin, y: (kScreenHeight-KBtnW*9-tabHeight-2*spaceMargin), width: kScreenWidth-2*spaceMargin, height: KBtnW*9)
            case .center:
                self.layer.setValue(1.0, forKeyPath: "transform.scale")
            case .top:
                self.frame = CGRect(x: spaceMargin, y: navHeight+44, width: kScreenWidth-2*spaceMargin, height: KBtnW*9)
            }
        }
        
        self.backgroundColor = UIColor(hexString: "#efeff4")
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.getCurrentDate()
        self.creatControl()
        self.reloadData()
        
    }
    //MARK:-弹出视图
    @objc func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            switch self.animationType {
            case .bottom:
                self.frame = CGRect(x: spaceMargin, y: kScreenHeight+tabHeight, width: kScreenWidth-2*spaceMargin, height: KBtnW*9)
            case .center:
                self.layer.setValue(0, forKeyPath: "transform.scale")
            case .top:
                self.frame = CGRect(x: spaceMargin, y: -kScreenHeight, width: kScreenWidth-2*spaceMargin, height: KBtnW*9)
            }
            self.control?.alpha = 0
        }) { (finished) in
            self.control?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

    //MARK:返回今天
    @objc fileprivate func backTodayBtnOnClick(_ sender: UIButton) {
        year = currentYear
        month = currentMonth
        selectYear = currentYear
        selectMonth = currentMonth
        day = currentDay
        self.reloadData()
    }
    //MARK:上一月点击
    @objc fileprivate func preBtnOnClick(_ sender: UIButton) {
        if month == 1 {
            if yearBtn.row == 0 { return }
            year = year!-1
            month = 12
            yearBtn.row = yearBtn.row!-1
        } else {
            month = month!-1
        }
        
        monthBtn.row = month! - 1
        self.reloadData()
    }
    
    //MARK:下一月按钮点击
    @objc fileprivate func nextBtnOnClick(_ sender: UIButton) {
        if month == 12 {
            if yearBtn.row == (KShowYearsCount - 1) { return }
            year = year!+1
            month = 1
            yearBtn.row = yearBtn.row!+1
        } else {
            month = month!+1
        }
        monthBtn.row = month! + 1
        self.reloadData()
    }
    
    //MARK:刷新界面
    fileprivate func reloadData() {
        let totalDays = self.numberOfDaysInMonth()
        let firstDay = self.firstDayOfWeekInMonth()
        yearLabel.text = "\(year ?? 0)"
        monthLabel.text = "\(month ?? 0)月"
        yearBtn.title = "\(year ?? 0)年"
        monthBtn.title = "\(month ?? 0)月"
        
        for i in 0...KMaxCount {
            if let btn = self.calendarView.viewWithTag(i+KBtnTag) as? UIButton {
                btn.isSelected = false
                if i < (firstDay - 1) || (i > (totalDays + firstDay - 2)) {
                    btn.isEnabled = false
                    btn.setTitle("", for: .normal)
                } else {
                    if year == selectYear && month == selectMonth {
                        if day == (btn.tag - KBtnTag - (firstDay - 2)) {
                            btn.isSelected = true
                            let week = weekArray?[(btn.tag - KBtnTag)%7]
                            weekLabel.text = "星期\(week ?? "")"
                            dayLabel.text = "\(day ?? 0)"
                        }
                    } else {
                        btn.isSelected = false
                        dayLabel.text = nil
                    }

                    btn.isEnabled = true
                    let d = i - (firstDay - 1) + 1
                    btn.setTitle("\(d)", for: .normal)
                }
            }
        }
    }
    
    //MARK:-计算字体大小
    func calculateTextSize(text: String, font: UIFont) -> CGSize {
        let str = NSString(string: text)
        let size = str.size(withAttributes: [NSAttributedStringKey.font: font])
        return size
    }
    
    //根据颜色返回图片
    fileprivate func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //根据选中日期，获取相应NSDate
    fileprivate func getSelectDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents)!
    }
    
    //获取目标月份的天数
    fileprivate func numberOfDaysInMonth() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: self.getSelectDate())?.count ?? 0
    }
    
    //获取目标月份第一天星期几
    fileprivate func firstDayOfWeekInMonth() -> Int {
        //获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
        return Calendar.current.ordinality(of: .day, in: .weekOfYear, for: self.getSelectDate())!
    }
}

