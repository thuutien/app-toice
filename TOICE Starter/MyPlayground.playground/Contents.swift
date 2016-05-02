import Foundation



func getRandomFromArray(myArray: [String]) -> String {
    let randomIndex = arc4random_uniform(UInt32(myArray.count))
    return myArray[Int(randomIndex)]
    
}

func get3Words(myArray: [String]) -> [String] {
    var newArray:[String] = []
    let word1 = getRandomFromArray(myArray)
    newArray.append(word1)
    
    var word2 = getRandomFromArray(myArray)
    for var i in 0..<myArray.count{
        if word2 != word1 {
            newArray.append(word2)
            break
        }else {
            word2 = getRandomFromArray(myArray)
        }
        i += 1
    }
    
    var word3 = getRandomFromArray(myArray)
    for var i in 0..<myArray.count{
        if word3 != word1 && word3 != word2 {
            newArray.append(word3)
            break
        }else {
            word3 = getRandomFromArray(myArray)
        }
        i += 1
    }
    return newArray
}


var myArray1 = ["1","2","3","4"]

let newArray = get3Words(myArray1)
print(newArray)
