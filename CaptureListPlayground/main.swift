//
//  main.swift
//  CaptureListPlayground
//
//  Fernando Luiz Goulart - All rights reserved.
//

import Foundation

class ClassA {
    var name: String = "Empty FirstName"
    var surname: String = "Empty LastName"

    func setName(_ newName: String) {
        self.name = newName
    }

    func setSurname(_ newSurname: String) {
        self.surname = newSurname
    }

    func printIt() {
        print("\(name) \(surname)")
    }

    func run(_ classB: ClassB, newName: String, newSurname: String) {
        let otherRef: ClassA = ClassA()
        classB.execute { [weak self, name, surname] in
            DispatchQueue.global().async {
                print("Please wait 5 seconds")
                Thread.sleep(forTimeInterval: 5)
                self?.setName(newName)
                self?.setSurname(newSurname)
                self?.printIt()
                print("\(name) \(surname)")
                otherRef.setName(newName)
                otherRef.setSurname(newSurname)
                otherRef.printIt()
                print("Background Thread executed")
            }
        }
    }

    deinit {
        print("Class A deinit")
    }
}

class ClassB {
    func execute(completion: @escaping () -> Void) {
        completion()
    }

    deinit {
        print("Class B deinit")
    }
}

var classA: ClassA? = ClassA()
var classB: ClassB? = ClassB()

classA?.run(classB!, newName: "John", newSurname: "Doe")
classA = nil
classB = nil

print("Last line of main.swift 🎉")
RunLoop.main.run()
