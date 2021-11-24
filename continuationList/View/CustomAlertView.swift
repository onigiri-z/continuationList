import SwiftUI

struct CustomAlertView:View{
    
    @State private var inputText = ""
    @EnvironmentObject var baseData: BaseViewModel
    @FocusState var isFieldFocused: Bool
    
    var body: some View{
        if baseData.customAlert{
            ZStack{
                Color.brown.opacity(0.3).ignoresSafeArea()
                VStack{
                    Text(MyConst.名前の変更)
                    TextField(baseData.models[baseData.editNameIndex].name,text:$inputText)
                        .background(Color.white).frame(width:200)
                        .focused($isFieldFocused, equals: true)
                    Divider()
                    HStack{
                        Button(action:{
                            withAnimation{
                                baseData.customAlert.toggle()
                            }
                        }){
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        Button(action:{
                            baseData.editName(index: baseData.editNameIndex, value: inputText)
                            withAnimation{
                                baseData.customAlert.toggle()
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


struct CustomAlertView_Previews: PreviewProvider {
    @State static var bool = true
    @State static var index = 0
    @StateObject static var baseData2 = BaseViewModel()
    static var previews: some View {
        CustomAlertView().environmentObject(baseData2)
    }
}
