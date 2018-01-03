//
//  CalculatorViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Math: Int {
    case plus = 0
    case sub
    case multi
    case divide
}

final class CalculatorViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var firstNumberField: UITextField!
    @IBOutlet private weak var secondNumberField: UITextField!

    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var subButton: UIButton!
    @IBOutlet private weak var multiButton: UIButton!
    @IBOutlet private weak var divideButton: UIButton!

    @IBOutlet private weak var resultLabel: UILabel!

    let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "calculator"

        setup()
    }

    private func setup() {
        let plus = plusButton.rx.tap.map { Math.plus }
        let sub = subButton.rx.tap.map { Math.sub }
        let multi = multiButton.rx.tap.map { Math.multi }
        let divide = divideButton.rx.tap.map { Math.divide }

        let taps = Observable.of(plus, sub, multi, divide).merge().startWith(.plus)

        Observable.combineLatest(firstNumberField.rx.text.orEmpty, secondNumberField.rx.text.orEmpty ,taps)
        { (first, second, math) -> Int in
            let first = Int(first) ?? 0
            let second = Int(second) ?? 0

            return self.calculator(first: first, second: second, math: math)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)

        taps.subscribe(onNext: { [weak self] math in
            guard let this = self else { return }
            let selectedColor = UIColor.red
            this.plusButton.backgroundColor = (math == .plus ? selectedColor : UIColor.lightGray)
            this.subButton.backgroundColor = (math == .sub ? selectedColor : UIColor.lightGray)
            this.multiButton.backgroundColor = (math == .multi ? selectedColor : UIColor.lightGray)
            this.divideButton.backgroundColor = (math == .divide ? selectedColor : UIColor.lightGray)
        })
            .disposed(by: disposeBag)

    }


    private func calculator(first: Int, second: Int, math: Math) -> Int {
        switch math {
        case .plus: return first + second
        case .sub: return first - second
        case .multi: return first * second
        case .divide: return second > 0 ? (first / second) : 0
        }
    }
}
