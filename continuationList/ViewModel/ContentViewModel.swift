import Foundation
import SwiftUI

class ContentViewModel:ObservableObject,SaveDereatProtocol{
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

protocol SaveDereatProtocol{
    func delete(ID:String)
    func save()
}
