import Foundation
import SwiftUI

class ContentViewModel:ObservableObject,sese{
    @Published var models:[ConstThingClass] = []
    
    let fileController = FileController()
    
    init(){
        for ll in fileController.fileDataModel.constList{
            models.append(ConstThingClass(name: ll.name, date: ll.date))
        }
    }
    
    func add(name:String){
        models.append(ConstThingClass(name: name, date: myDateFormat.string(from: Date())))
    }
    
    func delete(ID:String){
        for i in 0...models.count-1{
            if models[i].model.id == ID{
                models.remove(at: i)
                return
            }
        }
    }
    
    func save(){
        var arr:[ConstThingModel] = []
        for dd in models{
            arr.append(dd.model)
        }
        
        //保存
        fileController.setfiledata(arr: arr)
        fileController.saveDataModel()
    }
}

protocol sese{
    func delete(ID:String)
    func save()
}

class ConstThingClass:ObservableObject{
    @Published var model:ConstThingModel
    
    init(name:String,date:String){
        model = ConstThingModel(name: name, date: date)
    }
}
