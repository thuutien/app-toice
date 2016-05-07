import Foundation

func getRandomArrayElement( myArray: [String], removeIt: Bool) -> ([String], String) {
    var newArray = myArray
    let randomValue = arc4random_uniform(UInt32(myArray.count))
    let newElement = myArray[Int(randomValue)]
    
    if removeIt {
        newArray.removeAtIndex(Int(randomValue))
        return (newArray, newElement)
    }else {
        return (newArray, newElement)
    }
}





func get3Element(yourArray: [String]) -> ([String],[String]) {
    var removedArray = yourArray
    var newArray:[String] = []
    let element1 = getRandomArrayElement(yourArray, removeIt: true)
    removedArray = element1.0
    newArray.append(element1.1)
    
    var element2 = getRandomArrayElement(yourArray, removeIt: false)
    for _ in 0..<removedArray.count {
        if element2.1 != element1.1 {
            newArray.append(element2.1)
            break
        }else{
            element2 = getRandomArrayElement(yourArray, removeIt: false)
        }
    }
    var element3 = getRandomArrayElement(yourArray, removeIt: false)
    for _ in 0..<removedArray.count {
        if element3.1 != element2.1 && element3.1 != element1.1{
            newArray.append(element3.1)
            break
        }else{
            element3 = getRandomArrayElement(yourArray, removeIt: false)
        }
    }
    
    return (newArray, removedArray)
    
}
var testArray = ["1","2","3","4","5"]
let newArray = get3Element(testArray)
 let newArray1 = get3Element(testArray)

