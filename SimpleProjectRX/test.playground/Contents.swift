//: Playground - noun: a place where people can play

import RxSwift

var bag = DisposeBag()

// element
func myJust<T>(_ element: T) -> Observable<T> {
    return Observable.create({ observer in
        observer.onNext(element)
        observer.onCompleted()
        return Disposables.create()
    })
}

myJust("fdadf").subscribe(onNext: {
    print($0)
}, onCompleted: {
print("comple")
}).addDisposableTo(bag)

// elements
func myArray<T>(_ elements: [T]) -> Observable<T> {
    return Observable.create({ observer in
        for element in elements {
            observer.onNext(element)
        }
        observer.onCompleted()
        return Disposables.create()
    })
}

print("\n=================== \n")

let strings = myArray(["hello", "play"])

strings.subscribe(onNext: {
    print($0)
}).addDisposableTo(bag)

print("=======================")

func myInterval(_ timeInterval: TimeInterval) -> Observable<Int> {
    return Observable.create({ observer in
        print("main Subcribe")
        let time = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        time.schedule(deadline: DispatchTime.now() + timeInterval, repeating: timeInterval)

        let cancel = Disposables.create {
            print("main disposable")
            time.cancel()
        }

        var next = 0

        time.setEventHandler(handler: {
            if cancel.isDisposed {
                return
            } else {
                observer.on(.next(next))
                next += 1
            }
        })
         time.resume()
        return cancel
    })
}

let counter = myInterval(0.1)

print("\nstart")
let subcripOne = counter.subscribe(onNext: {
    print("1) \($0)")
})

let subcripTwo = counter.subscribe(onNext: {
    print("2) \($0)")
})

Thread.sleep(forTimeInterval: 0.5)
subcripOne.dispose()

Thread.sleep(forTimeInterval: 0.5)
subcripTwo.dispose()

print("end")









