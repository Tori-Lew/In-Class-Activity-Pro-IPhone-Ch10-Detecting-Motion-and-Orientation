//
//  ContentView.swift
//  In-Class Activity Pro IPhone Ch10 Detecting Motion and Orientation
//
//  Created by Student Account on 11/15/23.
//

import SwiftUI
import CoreMotion
struct ContentView: View {
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    @State private var x: Double = 0.0
    @State private var y: Double = 0.0
    @State private var z: Double = 0.0
    @State private var arx: Double = 0.0
    @State private var ary: Double = 0.0
    @State private var arz: Double = 0.0
    @State private var orx: Double = 0.0
    @State private var ory: Double = 0.0
    @State private var orz: Double = 0.0
    @State private var pitch: Double = 0.0
    @State private var yaw: Double = 0.0
    @State private var roll: Double = 0.0
    var body: some View {
        VStack{
            Text("The device's current acceleration")
            Text("x: \(x)")
            Text("y: \(y)")
            Text("z: \(z)")
            Text("The device's current rate of rotation")
            Text("x: \(arx)")
            Text("y: \(ary)")
            Text("z: \(arz)")
            Text("The device's current orientation")
            Text("x: \(orx)")
            Text("y: \(ory)")
            Text("z: \(orz)")
            Text("The device's current attitude / angle")
            Text("Pitch: \(pitch)")
            Text("Yaw: \(yaw)")
            Text("Roll: \(roll)")
        }
        .onAppear {
            motionManager.startAccelerometerUpdates(to: queue) { (data: CMAccelerometerData?, error: Error?) in
                    guard let data = data else {
                        print("Error: \(error!)")
                        return
                    }
                let trackMotion: CMAcceleration = data.acceleration
                motionManager.accelerometerUpdateInterval = 2
                DispatchQueue.main.async {
                    x = trackMotion.x
                    y = trackMotion.y
                    z = trackMotion.z
                }
            }
            motionManager.startGyroUpdates(to: queue) { (data: CMGyroData?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                let trackMotion: CMRotationRate = data.rotationRate
                motionManager.gyroUpdateInterval = 2
                DispatchQueue.main.async {
                    arx = trackMotion.x
                    ary = trackMotion.y
                    arz = trackMotion.z
                }
            }
            motionManager.startMagnetometerUpdates(to: queue) { (data: CMMagnetometerData?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                let trackMotion: CMMagneticField = data.magneticField
                motionManager.magnetometerUpdateInterval = 2
                DispatchQueue.main.async {
                    orx = trackMotion.x
                    ory = trackMotion.y
                    orz = trackMotion.z
                }
            }
            motionManager.startDeviceMotionUpdates(to: queue) { (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                let trackMotion: CMAttitude = data.attitude
                motionManager.deviceMotionUpdateInterval = 2
                DispatchQueue.main.async {
                    pitch = trackMotion.pitch
                    yaw = trackMotion.yaw
                    roll = trackMotion.roll
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
