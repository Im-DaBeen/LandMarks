import SwiftUI
import ARKit
import SceneKit

struct FaceTrackingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let sceneView = ARSCNView(frame: viewController.view.bounds)
        sceneView.delegate = context.coordinator

        // Face Tracking 지원 기기인지 확인
        guard ARFaceTrackingConfiguration.isSupported else {
            print("❌ 이 기기는 Face Tracking을 지원하지 않습니다.")
            return viewController
        }

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        sceneView.session.run(config, options: [])

        viewController.view.addSubview(sceneView)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return }
            let blendShapes = faceAnchor.blendShapes

            let smileLeft = blendShapes[.mouthSmileLeft]?.floatValue ?? 0
            let smileRight = blendShapes[.mouthSmileRight]?.floatValue ?? 0
            let jawOpen = blendShapes[.jawOpen]?.floatValue ?? 0
            let browDownLeft = blendShapes[.browDownLeft]?.floatValue ?? 0

            // 간단한 감정 추정
            if smileLeft > 0.5 && smileRight > 0.5 {
                print("😊 감정: 행복해 보입니다.")
            } else if jawOpen > 0.6 {
                print("😮 감정: 놀람")
            } else if browDownLeft > 0.6 {
                print("😠 감정: 화남")
            } else {
                print("😐 감정: 중립")
            }
        }
    }
}
