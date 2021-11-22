import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section(header: Text("サポート")) {
                Text("お問い合わせ")
                Text("レビューする")
                Text("このアプリを共有する")
                Text("v1.2")
            }
        }.listStyle(GroupedListStyle())
        .navigationTitle(Text("設定"))

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
