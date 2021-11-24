import Foundation
import SwiftUI

class BaseViewModel:ObservableObject{
    @Published var models:[ConstThingModel] = []
    // Tab Bar...
    @Published var currentTab: Tab = .Home
    //アラート１
    @Published var customAlert = false
    //アラート２
    @Published var createNew = false
    @Published var editNameIndex = 0
    
    let fileController = FileController()
    
    init(){
        for ll in fileController.fileDataModel.constList{
            models.append(ConstThingModel(name: ll.name, startDate: ll.startDate))
        }
    }
    
    func editName(index:Int,value:String){
        models[index].name = value
        self.save()
    }
    
    func editDate(index:Int,value:Date){
        models[index].startDate = myDateFormat.string(from: value)
        self.save()
    }
    
    func add(name:String){
        models.append(ConstThingModel(name: name, startDate: myDateFormat.string(from: Date())))
        self.save()
    }
    
    func save(){
        var arr:[ConstThingModel] = []
        for dd in models{
            arr.append(dd)
        }
        //保存
        fileController.setfiledata(arr: arr)
        fileController.saveDataModel()
        
        print("保存しました。")
    }
}

// Enum Case for Tab Items...
enum Tab: String{
    case Home = "house"
    case Setting = "gearshape"
}
