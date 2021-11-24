import SwiftUI

struct AlbumView : View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var baseData: BaseViewModel
    @Binding var model:ConstThingModel
    
    var index:Int
    @State var date = Date()
    var body: some View{
        HStack{
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Text(model.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    if editMode?.wrappedValue == .active{
                        Image(systemName: "pencil")
                    }
                }.onTapGesture{
                    if editMode?.wrappedValue == .active{
                        print("名前編集")
                        baseData.editNameIndex = index
                        withAnimation{
                            baseData.customAlert.toggle()
                        }
                    }
                }
                
                if editMode?.wrappedValue == .active{
                    HStack{
                        Text(model.startDate)
                        DatePicker(
                            "開始日",
                            selection: $date,
                            in: ...Date(),
                            displayedComponents:.date
                        ).labelsHidden()
                            .onChange(of: date, perform: { value in
                                print(myDateFormat.string(from: value))
                                baseData.editDate(index: index, value: value)
                            });
                        
                    }
                }
                if editMode?.wrappedValue == .inactive{
                    Text(model.getPassedDays()+" "+MyConst.日)
                        .font(.title3)
                        .fontWeight(.light)
                }
            }
            .padding()
            
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    @State static var model = ConstThingModel(name: "サンプロ", startDate: "2021/10/5")
    static var previews: some View {
        ContentView()
    }
}


