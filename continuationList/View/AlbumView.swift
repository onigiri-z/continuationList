import SwiftUI

struct AlbumView : View {
    @Binding var model:ConstThingModel
    
    var body: some View{
        
        HStack{
            //aligmentは左ぞろえ　spacingで間の感覚指定
            VStack(alignment: .leading, spacing: 2) {
                Text(model.name)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(model.getPassedDays()+" 日")
                    .fontWeight(.light)
                    .foregroundColor(.black)
            }
            .padding()
            //.padding(.leading,10)
            
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(.gray)
                .padding()
        }
        .background(Color.white.shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 4))
        .cornerRadius(15)
    }
}

struct AlbumView_Previews: PreviewProvider {
    @State static var model = ConstThingModel(name: "サンプロ", startDate: "2021年10月5日")
    static var previews: some View {
        AlbumView(model: $model)
    }
}
