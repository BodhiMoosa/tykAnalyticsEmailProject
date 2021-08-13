
import Vapor
import SendGrid

func getErrorsByKey(object: CallLogObject) -> [KeyWithResponseCodeObject] {
    var objectArray : [KeyWithResponseCodeObject] = []
    
    for x in object.data {
        // if this method's array already has an object for the API KEY
        if let index = objectArray.firstIndex(where: {$0.apiKey == x.apiKey }) {
            //if this method's array contains that object AND there's a response code logged already
            if let responseCodeObjectIndex = objectArray[index].responseCode.firstIndex(where: { $0.responseCode == x.responseCode }) {
                objectArray[index].responseCode[responseCodeObjectIndex].count += 1
                objectArray[index].responseCode[responseCodeObjectIndex].dateArray.append(x.timeStamp)
            } else {
                objectArray[index].responseCode.append(ResponseCodeObject(
                    responseCode: x.responseCode,
                    count: 1,
                    dateArray: [x.timeStamp]))
            }
        } else {
            objectArray.append(KeyWithResponseCodeObject(
                apiKey: x.apiKey,
                responseCode: [ResponseCodeObject(
                    responseCode: x.responseCode,
                    count: 1, dateArray:
                        [x.timeStamp])]))
        }
    }
    return objectArray
}


func getMinutesUntil(militaryTimeHour: Int) -> Int {
    var safeHour = 0
    if militaryTimeHour > 23 {
        if militaryTimeHour == 24 {
            safeHour = 0
        } else {
            safeHour = 5
        }
    } else {
        safeHour = militaryTimeHour
    }
    let date                    = Date()
    let formatter               = DateFormatter()
    formatter.timeZone          = .current
    formatter.dateFormat        = "HH:mm"
    let hours                   = formatter.string(from: date).components(separatedBy: [":"])[0]
    let minutes                 = formatter.string(from: date).components(separatedBy: [":"])[1]
    var remainingTimeAsMinutes  = 0
    if let intHours             = Int(hours), let intMinutes = Int(minutes) {
        if intHours < safeHour {
            remainingTimeAsMinutes = ((safeHour - intHours) * 60) - intMinutes
        } else if intHours == safeHour && intMinutes == 0 {
            remainingTimeAsMinutes = 0
        } else if intHours == safeHour {
            remainingTimeAsMinutes = 1440 - intMinutes
        } else {
            remainingTimeAsMinutes = (1440 - ((intHours - safeHour) * 60)) - intMinutes
        }
        return remainingTimeAsMinutes
    } else {
        return 0
    }
    
}

