import Foundation
struct FileDataModel:Codable{
    //継続物の配列
    var constList :[ConstThingModel] = [ConstThingModel(name: "筋トレ", startDate: "2021年10月11日")]
}
