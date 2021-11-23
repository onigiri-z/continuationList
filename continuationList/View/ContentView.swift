import SwiftUI

struct ContentView: View {

    
    @ObservedObject var viewModel = ContentViewModel()
    @Environment(\.colorScheme) var scheme
    var body: some View {
        List{
            ForEach(0..<viewModel.models.count, id: \.self) { index in
                NavigationLink(destination: SubView(model: $viewModel.models[index], delegate: viewModel), label: {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(viewModel.models[index].name)
                            .fontWeight(.bold)
                        Text(viewModel.models[index].getPassedDays()+" "+MyConst.日)
                            .fontWeight(.light)
                    }.font(.system(size: 20, weight: .black, design: .default))
                     .padding(5)
                    }
                )
            }.onMove(perform: rowReplace).onDelete(perform: delete)
        }
        .toolbar {EditButton()}
        .listStyle(InsetGroupedListStyle())
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
        .overlay(
            
            // FAB Button...
            Button(action: {
                let alertView = UIAlertController(title: MyConst.新規作成, message: nil, preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                
                let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
                    
                    // Verifying OTP
                    if let otp = alertView.textFields![0].text{
                        viewModel.add(name: otp)
                    }
                }
                
                alertView.addTextField { (txt) in
                    txt.placeholder = MyConst.名前
                }
                
                alertView.addAction(cancel)
                alertView.addAction(ok)
                
                // Presentitng...
                UIApplication.shared.windows.first?.rootViewController?.present(alertView, animated: true, completion: nil)
                
                
                print(viewModel.models.count)
            }, label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundColor(scheme == .dark ? Color.black : Color.white)
                    .padding()
                    .background(.primary,in: Circle())
            })
                .padding()
                .foregroundStyle(.primary)
            ,alignment: .bottomTrailing
        )
        .onDisappear{viewModel.save()}
        .navigationBarTitle(Text("Poom"), displayMode: .inline)
        .navigationBarItems(trailing:
                                NavigationLink(destination: SettingView(), label:{Image(systemName: "gearshape")} ))
    }
    
    //行入れ替え処理
    func rowReplace(_ from: IndexSet, _ to: Int) {
        viewModel.models.move(fromOffsets: from, toOffset: to)
        viewModel.save()
    }
    //削除処理
    func delete(at offsets: IndexSet) {
        viewModel.models.remove(atOffsets: offsets)
        viewModel.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
