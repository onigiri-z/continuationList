import Foundation
import SwiftUI

class SubViewModel:ObservableObject{
    @Published var startAnimation = false

    
    func animateView(){
        
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)){
            
            startAnimation.toggle()
        }
    }
}
