import SwiftUI

struct CreateNewView:View{
    
    @State private var inputText = ""
    @EnvironmentObject var baseData: BaseViewModel
    @FocusState var isFieldFocused: Bool
    
    var body: some View{
        if baseData.createNew{
            ZStack{
                Color.brown.opacity(0.3).ignoresSafeArea()
                VStack{
                    Text(MyConst.新規作成)
                    TextField(MyConst.名前,text:$inputText)
                        .background(Color.white).frame(width:200)
                        .focused($isFieldFocused, equals: true)
                    Divider()
                    HStack{
                        Button(action:{
                            withAnimation{
                                baseData.createNew.toggle()
                            }
                        }){
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        Button(action:{
                            baseData.add(name: inputText)
                            withAnimation{
                                baseData.createNew.toggle()
                            }
                        }){
                            Spacer()
                            Text("OK")
                            Spacer()
                        }
                        Spacer()
                    }.overlay(HStack{Divider()})
                }.padding().fixedSize()
                    .background(Color.gray.brightness(0.5)).cornerRadius(20)
            }.onAppear{
                inputText = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {  /// Anything over 0.5 seems to work
                    isFieldFocused = true
                 }
            }
        }
    }
}




struct CreateNewView_Previews: PreviewProvider {
    @State static var bool = true
    @State static var index = 0
    @StateObject static var baseData2 = BaseViewModel()
    static var previews: some View {
        CreateNewView().environmentObject(baseData2)
    }
}
