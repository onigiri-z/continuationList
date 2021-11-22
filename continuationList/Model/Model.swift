import Foundation

//継続物モデル
struct ConstThingModel:Codable{
    //ID macmini
    var id = UUID().uuidString
    //名前
    var name:String
    //開始日
    var startDate:String
    //何日経過したか
    func getPassedDays()->String{
        let date1 = myDateFormat.date(from: self.startDate)
        let date2 = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: date1!, to: date2).day!
        return "\(elapsedDays)"
    }
}
