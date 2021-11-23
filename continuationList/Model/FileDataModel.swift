import Foundation
struct FileDataModel:Codable{
    //継続物の配列
    var constList :[ConstThingModel] = [ConstThingModel(name: MyConst.筋トレ, startDate: "2021/10/11"),
                                        ConstThingModel(name: MyConst.ランニング, startDate: "2021/8/11")]
}
