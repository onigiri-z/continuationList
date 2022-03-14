import SwiftUI

struct BaseView: View {
    @StateObject var baseData = BaseViewModel()
    
    init(){
        UITabBar.appearance().isHidden = true
        //List全体の背景色の設定
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        TabView(selection: $baseData.currentTab) {
            Home()
                .environmentObject(baseData)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.05))
                .tag(Tab.Home)
            
            SettingView()
                .tag(Tab.Setting)
            
        }
        .overlay(AdmobBannerView().frame(width: 302, height: 50).offset(y:UIScreen.main.bounds.size.height/3.2))
        .overlay(
                //カスタムタブバー
                HStack(spacing: 0){
                    TabButton(Tab: .Home)
                    Button {
                        withAnimation{
                            baseData.createNew.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .foregroundColor(.white)
                            .offset(x: -1)
                            .padding(18)
                            .background(Color("DarkBlue"))
                            .clipShape(Circle())
                        // shadows..
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                    }
                    .offset(y: -30)
                    
                    TabButton(Tab: .Setting)
                
            }.background(
                Color.white
                    .clipShape(CustomCurveShape())
                // shadow...
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                    .ignoresSafeArea(.container, edges: .bottom)
            )
            ,alignment: .bottom
        )
        .overlay(CustomAlertView().environmentObject(baseData))
        .overlay(CreateNewView().environmentObject(baseData))
    }
    
    @ViewBuilder
    func TabButton(Tab: Tab)-> some View{
        
        Button {
            withAnimation{
                baseData.currentTab = Tab
            }
        } label: {
            Image(systemName: Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(baseData.currentTab == Tab ? Color("DarkBlue") : Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
