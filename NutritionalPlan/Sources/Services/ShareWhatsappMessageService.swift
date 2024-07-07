//
//  ShareWhatsappMessageService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 01/07/2024.
//

import Foundation
import UIKit
import SwiftUI

class ShareWhatsappMessageService {
    
    @AppStorage("phoneNumber") var phoneNumber: String = "972544353679"
    
    func shareWhatsapp(message: String) {
        let urlString = "https://wa.me/\(phoneNumber)?text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let whatsappURL = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            } else {
                // WhatsApp is not installed
                print("WhatsApp is not installed on this device.")
            }
        }
    }
}
