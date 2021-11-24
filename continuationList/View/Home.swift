import SwiftUI

struct Home: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        VStack(spacing:0){
            HStack{
                Spacer()
                EditButton()
            }
            .overlay(Text("Poom").font(.title3).fontWeight(.bold))
            .frame(height:40)
            
            List{
                ForEach(0..<baseData.models.count, id: \.self) { index in
                    AlbumView(model: $baseData.models[index], index: index)
                        .environmentObject(baseData)
                }.onMove(perform: rowReplace).onDelete(perform: delete)
            }.listStyle(GroupedListStyle())
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity)
    }
    
    //行入れ替え処理
    func rowReplace(_ from: IndexSet, _ to: Int) {
        baseData.models.move(fromOffsets: from, toOffset: to)
        baseData.save()
    }
    //削除処理
    func delete(at offsets: IndexSet) {
        baseData.models.remove(atOffsets: offsets)
        print(baseData.models.count)
        baseData.save()
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
