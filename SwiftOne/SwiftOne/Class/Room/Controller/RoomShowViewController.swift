//
//  RoomShowViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import CLImagePickerTool
class RoomShowViewController: UIViewController {
    fileprivate lazy var videoQueue = DispatchQueue.global()
    private lazy var session : AVCaptureSession = AVCaptureSession()
    private lazy var larey : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    private lazy var image : UIImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension RoomShowViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        let btn = UIButton.init(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        btn.setTitle("上传图片", for: .normal)
        btn.backgroundColor = UIColor.red
        view.addSubview(btn)
        
        let btn2 = UIButton.init(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        btn2.setTitle("结束采集", for: .normal)
        btn2.backgroundColor = UIColor.red
        // view.addSubview(btn2)
        
        
        image.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        view.addSubview(image)
    
        btn.addTarget(self, action: #selector(start), for: .touchDragInside)
        btn.addTarget(self, action: #selector(stop), for: .touchDragInside)
    }
    @objc private func stop() {
        session.stopRunning()
        larey.removeFromSuperlayer()
    }
    @objc private func start() {
//             // 设置输入源
//        guard let device = AVCaptureDevice.default(for: .video) else {
//                // 摄像头不可用
//                return
//            }
//             //1.2视频输入
//        guard let input = try? AVCaptureDeviceInput(device: device) else {
//                print("get front video AVCaptureDeviceInput  failed!")
//                return
//            }
//
//            session.addInput(input)
//             // 设置输出源
//            //2 视频的输出
//            let output = AVCaptureVideoDataOutput();
//            output.setSampleBufferDelegate(self , queue: videoQueue)
//             session.addOutput(output)
//
//             // 给用户看到一个预览涂层
//             larey.frame = view.bounds
//             view.layer.insertSublayer(larey, at: 0)
//
//             // 开始采集
//             session.startRunning()
        let imagePickTool = CLImagePickerTool()
         // 不支持视频文件
        imagePickTool.isHiddenVideo = true
        // 设置图片单选
        imagePickTool.singleImageChooseType = .singlePicture
        // 单选图片，选择完成后进行裁剪操作imagePickTool.singlePictureCropScale = 2 //宽/高
        //imagePickTool.singleImageChooseType = .singlePictureCrop
         imagePickTool.singleModelImageCanEditor = true
        imagePickTool.cl_setupImagePickerAnotherWayWith(maxImagesCount: 2, superVC: self) { (asset,cutImage) in
             
            CLImagePickerTool.convertAssetArrToOriginImage(assetArr: asset, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                             PopViewUtil.share.stopLoading()
                             self!.image.image = image
                         }, failedClouse: { () in
                           PopViewUtil.share.stopLoading()
                            
                     })
        }
    }
}

extension RoomShowViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("采集到的画面了")
    }
}
