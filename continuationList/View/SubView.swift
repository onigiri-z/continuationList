import SwiftUI

struct SubView: View {
    @Binding var model:ConstThingModel
    @State private var date = Date()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var delegate:sese?
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var tententen = "..."
    var body: some View {
        VStack(spacing:10){
            Text(model.getNissuu()+"日継続中"+tententen).onReceive(timer)
            { input in
                if tententen == "..."{
                    tententen = ".  "
                }else if tententen == ".  "{
                    tententen = ".. "
                }else if tententen == ".. "{
                    tententen = "..."
                }
            }.frame(width:300)
            HStack{
                Text(model.name)
                Image(systemName: "pencil")
            }.onTapGesture {
                print("名前編集")
                let alertView = UIAlertController(title: "名前の変更", message: nil, preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                
                let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
                    
                    // Verifying OTP
                    if let otp = alertView.textFields![0].text{
                        model.name = otp
                    }
                }
                
                alertView.addTextField { (txt) in
                    txt.placeholder = model.name
                }
                
                alertView.addAction(cancel)
                alertView.addAction(ok)
                
                // Presentitng...
                UIApplication.shared.windows.first?.rootViewController?.present(alertView, animated: true, completion: nil)
            }
            HStack{
                Text(model.date)
                DatePicker(
                    "Date",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents:.date
                ).labelsHidden()
                    .onChange(of: date, perform: { value in
                        print(myDateFormat.string(from: value))
                        model.date = myDateFormat.string(from: value)
                    });
            }
            Button(action: {
                
                let alertView = UIAlertController(title: model.name+"を削除しますか？", message: nil, preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                
                let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
                    print("削除")
                    delegate?.delete(ID: model.id)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                
                alertView.addAction(cancel)
                alertView.addAction(ok)
                
                // Presentitng...
                UIApplication.shared.windows.first?.rootViewController?.present(alertView, animated: true, completion: nil)
            }){
                Text("削除").foregroundColor(.red)
            }.padding()
            Spacer().frame(height:120)
        }.font(.largeTitle).onDisappear{delegate?.save()}
    }
}

struct SubView_Previews: PreviewProvider {
    @State static var date = ConstThingModel(name: "禁断", date: "2021年10月1日")
    static var previews: some View {
        SubView(model: $date)
    }
}


var myDateFormat: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "yyyy年M月d日"
    return df
}
