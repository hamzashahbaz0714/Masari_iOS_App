//
//  Constants.swift
//  Waldaa
//
//  Created by Malik Javed Iqbal on 07/12/2020.
//

import UIKit
import Alamofire

let headers: HTTPHeaders = HTTPHeaders(["x-rapidapi-key": "20659b441fmshb185905e977f8a7p191811jsn2af781bf80db",
                                       "x-rapidapi-host": "api-football-v1.p.rapidapi.com"])
let baseBallHeaders: HTTPHeaders = HTTPHeaders([
    "x-rapidapi-key": "20659b441fmshb185905e977f8a7p191811jsn2af781bf80db",
    "x-rapidapi-host": "api-baseball.p.rapidapi.com"])

let HockeyHeaders: HTTPHeaders = ([
    "x-rapidapi-key": "20659b441fmshb185905e977f8a7p191811jsn2af781bf80db",
    "x-rapidapi-host": "api-hockey.p.rapidapi.com"])

let BasketballHeader:HTTPHeaders = [
    "x-rapidapi-key": "20659b441fmshb185905e977f8a7p191811jsn2af781bf80db",
    "x-rapidapi-host": "api-basketball.p.rapidapi.com"
]

let placeHolderLeage = UIImage(named: "bet_icon")
let placeHolderArtistImage = UIImage(named: "2")
let menuArr = [["image": UIImage(named: "icon_user_profile")!,"name":"Profile"],["image": UIImage(named: "icon_transactions")!,"name":"Transactions"],["image": UIImage(named: "icon_settings")!,"name":"Settings"]]
let sportArray = [["name": "NBA-Basketball", "image": UIImage(named: "icon_basketball")!],["name": "MLB-Baseball", "image": UIImage(named: "icon_baseball")!],["name": "NFL-Football", "image": UIImage(named: "icon_football")!],["name": "FIFA-Soccer", "image": UIImage(named: "icon_football")!],["name": "NHL-Ice Hockey", "image": UIImage(named: "icon_hockey")!]]


enum albumType: String {
    case newAlbum = "get-new-albums"
    case allAlbum = "get-all-albums"
    case weeklyCollection = "weekly-selection"

}

func getCurrentYear() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return (formatter.string(from: Date()))
}

func getCurrentDate() -> String{
    let currentDateTime = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return (formatter.string(from: currentDateTime))
}
func currentdateToaddOnday() -> String{
    let currentDate = Date()
    var dateComponent = DateComponents()
    dateComponent.day = 1
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
   return ((formatter.string(from: futureDate!)))
}

struct Currency {

    private static let formatter: NumberFormatter = {
        let formatter         = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static func stringFrom(_ decimal: Decimal, currency: String? = nil) -> String {
        return self.formatter.string(from: decimal as NSDecimalNumber)!
    }
}

func getdatefromUNixTimes(time: Double) -> String{
    let unixTimeStamp = time
    let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
    let dateFormatt = DateFormatter()
    dateFormatt.dateFormat = "dd/MM/yyy hh:mm a"
    return dateFormatt.string(from: exactDate as Date)

}
