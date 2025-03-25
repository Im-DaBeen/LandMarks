import SwiftUI
import ARKit
import SceneKit

struct FaceTrackingView: UIViewControllerRepresentable {
    @Binding var emotion: String

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let sceneView = ARSCNView(frame: viewController.view.bounds)
        sceneView.delegate = context.coordinator
        context.coordinator.emotionBinding = $emotion

        guard ARFaceTrackingConfiguration.isSupported else {
            emotion = "❌ Face Tracking 미지원 기기"
            return viewController
        }

        let config = ARFaceTrackingConfiguration()
        sceneView.session.run(config, options: [])
        viewController.view.addSubview(sceneView)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var emotionBinding: Binding<String>?

        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return }
            let blendShapes = faceAnchor.blendShapes

            let smileLeft = blendShapes[.mouthSmileLeft]?.floatValue ?? 0
            let smileRight = blendShapes[.mouthSmileRight]?.floatValue ?? 0
            let jawOpen = blendShapes[.jawOpen]?.floatValue ?? 0
            let browDownLeft = blendShapes[.browDownLeft]?.floatValue ?? 0

            var detectedEmotion = "😐 감정: 중립"
            if smileLeft > 0.5 && smileRight > 0.5 {
                detectedEmotion = "😊 감정: 행복"
            } else if jawOpen > 0.6 {
                detectedEmotion = "😮 감정: 놀람"
            } else if browDownLeft > 0.6 {
                detectedEmotion = "😠 감정: 화남"
            }

            DispatchQueue.main.async {
                self.emotionBinding?.wrappedValue = detectedEmotion
            }
        }
    }
}
