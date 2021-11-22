import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollView{
            VStack(spacing: 15){
                ForEach(0..<viewModel.models.count, id: \.self) { index in
                    NavigationLink(destination: SubView(model: $viewModel.models[index], delegate: viewModel), label: {AlbumView(model: $viewModel.models[index])}
                    ).frame(height: 80)
                }
            }
            .padding(.horizontal)
            .padding(.top,25)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
        .overlay(
            
            // FAB Button...
            Button(action: {
                let alertView = UIAlertController(title: "新規作成", message: nil, preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                
                let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
                    
                    // Verifying OTP
                    if let otp = alertView.textFields![0].text{
                        viewModel.add(name: otp)
                    }
                }
                
                alertView.addTextField { (txt) in
                    txt.placeholder = "名前"
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
    func scaleValue(mainFrame : CGFloat,minY : CGFloat)-> CGFloat{
        withAnimation(.easeOut){
            let scale = (minY - 25) / mainFrame
            if scale > 1{
                return 1
            }
            else{
                return scale
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
