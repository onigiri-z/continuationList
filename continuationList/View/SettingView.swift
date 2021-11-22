import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section(header: Text("サポート")) {
                
                Button(action: {
                    otoiawase()
                }, label: {
                    Text("お問い合わせ")
                })
                Button(action: {
                    reviewApp()
                }, label: {
                    Text("レビューする")
                })
                Button(action: {
                    shareApp()
                }, label: {
                    Text("このアプリを共有する")
                })
                Text("v"+version!)
            }
        }.listStyle(GroupedListStyle())
            .navigationTitle(Text("設定"))
        
    }
    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    let productURL:URL = URL(string: "https://apps.apple.com/us/app/%E7%B6%99%E7%B6%9A%E3%83%AA%E3%82%B9%E3%83%88-%E5%B0%8F%E3%81%95%E3%81%AA%E9%81%94%E6%88%90%E6%84%9F%E3%82%92%E6%8F%90%E4%BE%9B%E3%81%97%E3%81%BE%E3%81%99/id1594371097")!
    
    func otoiawase(){
        let productURL:URL = URL(string: "https://nimonimo.tokyo/%e3%81%8a%e5%95%8f%e3%81%84%e5%90%88%e3%82%8f%e3%81%9b/")!
        
        UIApplication.shared.open(productURL)
        
    }
    
    func shareApp(){
        
        let activityViewController = UIActivityViewController(
            activityItems: [productURL],
            applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func reviewApp(){
        
        
        var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        
        guard let writeReviewURL = components?.url else {
            return
        }
        
        UIApplication.shared.open(writeReviewURL)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
