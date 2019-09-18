//
//  Strings+Extension.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//

import Foundation


//MARK: - File Handling

var directoryPath:String! = nil
let resPath:String = Bundle.main.resourcePath!

public extension String{
    
    static func documentsDirectoryPath() -> String{
        if(directoryPath == nil){
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            directoryPath = (paths.count > 0) ? paths[0] : nil
        }
        return directoryPath
    }
    
    static func resourcePath(_ string:String) -> String{
        return (resPath as NSString).appendingPathComponent(string)
    }
    
}



//MARK:- URL

public extension String{
    
    func URL() -> Foundation.URL? {
        var trimmed = self.trimmedString()
        if(String.isBlank(trimmed)){
            return nil
        }
        trimmed = trimmed.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
        guard let url = Foundation.URL(string: trimmed) else{
            return nil
        }
        return url
    }
    
}



//MARK: - Validations

public extension String{
    
    func trimmedString() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    static func isBlank(_ input:String?) -> Bool {
        return input == nil || input!.trimmedString() == ""
    }
    
    static func isNotBlank(_ input:String?) -> Bool {
        return !String.isBlank(input)
    }
    
    func flattenEmail() -> String{
        var flatEmail = self.replacingOccurrences(of: "@", with: "")
        flatEmail = flatEmail.replacingOccurrences(of: ".", with: "")
        return flatEmail
    }
    
    func isValidEmail() -> Bool {
        let emailString = self
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
    
    func isValidInput() -> Bool {
        let str = self
        if(str.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            return false
        }else{
            return true
        }
    }
    
    func isValidPassword() -> Bool {
        let str = self
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: str)
    }
    
    func isValidURL() -> Bool{
        if self.isEmpty{
            return false
        }
        let actualURLString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        do {
            let regExPatern : String = "^((https|http)://)?\\w+\\.+\\w+"
            let regex = try NSRegularExpression(pattern: regExPatern, options: .dotMatchesLineSeparators)
            let nsString = actualURLString as NSString
            let results = regex.matches(in: nsString as String, options: .reportProgress, range: NSRange(location: 0, length: nsString.length))
            if results.count > 0{
                return true
            }
        } catch {
        }
        return false
    }
}



//MARK: - UI

public extension String{
    
    func getImageForDevice() ->String{
        if(UI_USER_INTERFACE_IDIOM() == .pad){
            if(UIApplication.shared.statusBarOrientation == .portrait || UIApplication.shared.statusBarOrientation == .portraitUpsideDown){
                return ((self as String) + "-Portrait")
            }else{
                return ((self as String) + "-Landscape")
            }
        }
        return (self as String)
    }
    
    func textHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func textWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func font(width: CGFloat, height: CGFloat, font: UIFont) -> UIFont{
        let constraintRect = CGSize(width: width, height: height)
        var pointSize = font.pointSize
        var newFont = font
        var boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        //        var textHeight = self.textHeight(width: width, font: newFont)
        while boundingBox.size.height > height{ //> boundingBox.size.height  {
            pointSize -= 1
            newFont = UIFont.init(name: font.fontName, size: pointSize)!
            boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: newFont], context: nil)
        }
        return newFont
    }
}
