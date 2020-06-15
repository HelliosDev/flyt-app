//
//  SpeechService.swift
//  Flyt
//
//  Created by Wendy Kurniawan on 15/06/20.
//  Copyright © 2020 Wendy Kurniawan. All rights reserved.
//

import AVFoundation
import UIKit

class SpeechService{
    
    let speechSynthizer = AVSpeechSynthesizer()
    
    func say(_ phrase:String){
        
//        guard UIAccessibility.isVoiceOverRunning else {
//            return
//        }
        
        let utterenece = AVSpeechUtterance(string: phrase)
        let langCode = "en-EN".localized
        utterenece.voice = AVSpeechSynthesisVoice(language: langCode)
        speechSynthizer.speak(utterenece)
    }
    
    func stop() {
        speechSynthizer.stopSpeaking(at: .immediate)
    }
}

extension String{
    var localized : String{
        return NSLocalizedString(self, comment: "")
    }
}
