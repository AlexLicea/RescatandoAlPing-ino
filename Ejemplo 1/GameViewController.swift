//
//  GameViewController.swift
//  Ejemplo 1
//
//  Created by Alexis Rogelio León Licea on 19/11/17.
//  Copyright © 2017 Evolution Technologies SA de CV. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var musicPlayer = AVAudioPlayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let menuScene = MenuScene()
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        menuScene.size = view.bounds.size
        skView.presentScene(menuScene)
        if let musicPath = Bundle.main.path(forResource: "Sound/BackgroundMusic.m4a", ofType: nil) {
            let url = URL(fileURLWithPath: musicPath)
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            } catch { /* Couldn't load music file */ }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
