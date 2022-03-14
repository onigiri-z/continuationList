import Foundation
import SwiftUI
import Firebase

struct AdmobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        #if DEBUG
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        //バナー広告のID
        view.adUnitID = "ca-app-pub-9399635509374312/8919520045"
        #endif
        view.rootViewController = UIApplication.shared.windows.first?.rootViewController
        view.load(GADRequest())
        return view
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
