# WHCalendar
纯Swift实现日历Demo
项目使用SnapKit进行约束布局
使用步骤:
let calendar = WHCalendar()
        calendar.dafaultDate = self.defaultDate
        calendar.animationType = .center
        //自定义显示界面
//        calendar.model = CalendarModel()
        calendar.callback = { [unowned self](value) in
            if let date = value as? String {
                self.defaultDate = dateFromFormat(date: date)
                self.dateButton.setTitle("设置日期: \(date)", for: .normal)
            }
        }
        calendar.show()
     
     
 注:
 1. calendar.animationType = .center  可以指定日历弹出样式  center  bottom  top
 2. calendar.model = CalendarModel() 可以自定义界面文字大小颜色
