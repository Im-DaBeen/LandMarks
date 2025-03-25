import SwiftUI
import ARKit
import RealityKit

struct FaceTrackingView: UIViewControllerRepresentable {
    let onLoad: (RealityKit.Scene) -> Void  // ✅ 클로저 추가

    init(onLoad: @escaping (RealityKit.Scene) -> Void) {
        self.onLoad = onLoad
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let arView = ARView(frame: viewController.view.bounds/*, cameraMode: .ar, automaticallyConfigureSession: true*/)

        // ✅ Face Tracking 지원 확인
        guard ARFaceTrackingConfiguration.isSupported else {
            print("❌ Face Tracking이 지원되지 않는 기기입니다.")
            return viewController
        }

        // ✅ AR 세션 시작
        let config = ARFaceTrackingConfiguration()
        arView.session.run(config, options: [])

        // ✅ 3D 모델 로드
                if let entity = try? Entity.load(named: "face_mask") {  // "face_mask.usdz" 파일 로드
                    let anchor = AnchorEntity(.face)
                    anchor.addChild(entity)
                    arView.scene.addAnchor(anchor)
                } else {
                    print("❌ 3D 모델을 찾을 수 없음: face_mask")
                }
        
        viewController.view.addSubview(arView)

        // ✅ RealityKit Scene을 onLoad 클로저에 전달
        DispatchQueue.main.async {
            self.onLoad(arView.scene)
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
