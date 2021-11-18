import Foundation
import SwiftUI

class ViewModel:ObservableObject,sese{
    @Published var models:[ConstThingModel] = []
    
    let fileController = FileController()
    
    init(){
        for ll in fileController.fileDataModel.constList{
            models.append(ConstThingModel(name: ll.name, startDate: ll.startDate))
        }
    }
    
    func add(name:String){
        models.append(ConstThingModel(name: name, startDate: myDateFormat.string(from: Date())))
    }
    

    
    func delete(ID:String){
        for i in 0...models.count-1{
            if models[i].id == ID{
                models.remove(at: i)
                return
            }
        }
    }
    
    func save(){
        var arr:[ConstThingModel] = []
        for dd in models{
            arr.append(dd)
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
    
    func getNissuu()->String{
        let date1 = myDateFormat.date(from: model.startDate)
        let date2 = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: date1!, to: date2).day!
        return "\(elapsedDays)"
    }
    
    init(name:String,date:String){
        model = ConstThingModel(name: name, startDate: date)
    }
}
