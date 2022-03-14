import SwiftUI

struct Home: View {
    @EnvironmentObject var baseData: BaseViewModel
    @Environment(\.editMode) var envEditMode
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
                }.onMove(perform: baseData.rowReplace)
                    .onDelete(perform: baseData.delete)
            }.listStyle(GroupedListStyle())
            
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
