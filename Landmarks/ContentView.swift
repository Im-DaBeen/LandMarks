import SwiftUI
//import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        FaceTrackingView()
            .edgesIgnoringSafeArea(.all)

//        { scene in
//            let anchor = AnchorEntity(world: .zero)
//            scene.addAnchor(anchor)
//            
//            if let entity = try? Entity.load(named: "my_3d_model") {
//                scene.addAnchor(AnchorEntity(world: .zero))
//                scene.anchors.first?.addChild(entity)
//            } else {
//                print("❌ 3D 모델을 찾을 수 없음: my_3d_model")
//            }
//            do {
//                let entity = try Entity.load(named: "my_3d_model")
//                anchor.addChild(entity)
//            } catch {
//                print("❌ 3D 모델을 찾을 수 없음: my_3d_model, \(error)")
            
        
    }
}

#Preview {
    ContentView()
}
