import SwiftUI

struct SubView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //コメントを追加しました。 ローカルのdev_branchで追加した。
    @Binding var model:ConstThingModel
    var delegate:SaveDereatProtocol?
    @ObservedObject var viewModel = SubViewModel()
    @State var date = Date()
    var body: some View {
        ZStack{
            VStack(spacing:10){
                HStack{
                    Text(model.getPassedDays()+"日継続中")
                    ZStack{
                        
                        Circle()
                            .trim(from: 0, to: 0.4)
                            .stroke(Color.blue,lineWidth: 1.4)
                            .frame(width:20, height: 20)
                        
                        Circle()
                            .trim(from: 0, to: 0.4)
                            .stroke(Color.blue,lineWidth: 1.4)
                            .rotationEffect(.init(degrees: -180))
                            .frame(width:20, height: 20)
                    }
                    .rotationEffect(.init(degrees: viewModel.startAnimation ? 360 : 0))
                }
               
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
                    Text(model.startDate)
                    DatePicker(
                        "Date",
                        selection: $date,
                        in: ...Date(),
                        displayedComponents:.date
                    ).labelsHidden()
                        .onChange(of: date, perform: { value in
                            print(myDateFormat.string(from: value))
                            model.startDate = myDateFormat.string(from: value)
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
            }.frame(maxHeight: .infinity).font(.largeTitle).onDisappear{delegate?.save()}
        }.ignoresSafeArea()
            .onAppear(perform: {
                viewModel.animateView()
            })
        
    }
}

struct SubView_Previews: PreviewProvider {
    @State static var date = ConstThingModel(name: "禁断", startDate: "2021年10月1日")
    static var previews: some View {
        SubView(model: $date)
    }
}


var myDateFormat: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "yyyy年M月d日"
    return df
}
