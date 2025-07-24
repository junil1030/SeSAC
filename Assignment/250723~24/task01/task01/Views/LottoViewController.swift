//
//  LottoViewController.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    
    lazy var inputTextView: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.font = .systemFont(ofSize: 16)
        textField.tintColor = .clear
        textField.textAlignment = .center
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([space, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        
        textField.inputView = picker
        return textField
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜 레이블"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let lineLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .lightGray
        return label
    }()
    
    let roundResultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let ballStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private var winningNumbers: [Int] = []
    private var bonusNumber: Int = 0
    private var availableRounds: [Int] = []
    private var currentRound: Int = 0
    
    private var ballSize: CGFloat = 0
    private var ballSpacing: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        calculateBallLayout()
        
        setupInitialData()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        selectLatestRoundInPicker()
    }
    
    private func calculateBallLayout() {
        let screenWidth = UIScreen.main.bounds.width
        let sideMargin: CGFloat = 40
        let availableWidth = screenWidth - sideMargin
        let ballCount: CGFloat = 8
        let minSpacing: CGFloat = 4
        
        let totalMinSpacing = minSpacing * (ballCount - 1)
        ballSize = (availableWidth - totalMinSpacing) / ballCount
        ballSpacing = minSpacing
        
        ballStackView.spacing = ballSpacing
    }
    
    private func setupInitialData() {
        let latestRound = calculateLatestRound()
        availableRounds = Array(1...latestRound)
        currentRound = latestRound
        
        updateRoundResult(round: currentRound)
    }
    
    private func selectLatestRoundInPicker() {
        if let picker = inputTextView.inputView as? UIPickerView {
            let lastIndex = availableRounds.count - 1
            picker.selectRow(lastIndex, inComponent: 0, animated: true)
            inputTextView.text = "\(availableRounds[lastIndex])"
        }
    }
    
    private func calculateLatestRound() -> Int {
        let firstDrawDate = Calendar.current.date(from: DateComponents(year: 2002, month: 12, day: 7))!
        let today = Date()
        
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.weekday, .hour], from: today)
        let isSaturday = todayComponents.weekday == 7
        
        var targetDate = today
        
        if isSaturday {
            targetDate = calendar.date(byAdding: .day, value: -7, to: today) ?? today
        } else if !isSaturday {
            let daysFromSaturday = (todayComponents.weekday ?? 1) % 7
            targetDate = calendar.date(byAdding: .day, value: -daysFromSaturday, to: today) ?? today
        }
        
        let daysBetween = calendar.dateComponents([.day], from: firstDrawDate, to: targetDate).day ?? 0
        let weeksBetween = daysBetween / 7
        
        return max(1, weeksBetween + 1)
    }
    
    @objc func dismissPicker() {
        inputTextView.resignFirstResponder()
    }
    
    private func updateRoundResult(round: Int) {
        let fullText = "\(round)회 당첨결과"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let roundText = "\(round)회"
        attributedString.addAttribute(.foregroundColor,
                                    value: UIColor.systemYellow,
                                    range: NSRange(location: 0, length: roundText.count))
        
        attributedString.addAttribute(.foregroundColor,
                                    value: UIColor.black,
                                    range: NSRange(location: roundText.count + 1, length: 4))
        
        roundResultLabel.attributedText = attributedString
        
        fetchLottoNumbers(round: round)
    }
    
    private func generateLottoNumbers() {
        ballStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for number in winningNumbers {
            let ballView = LottoBallView()
            let ballType = BallType.ballType(for: number)
            ballView.configure(number: number, ballType: ballType)
            ballStackView.addArrangedSubview(ballView)
        }
        
        let plusView = LottoBallView()
        plusView.configurePlus()
        ballStackView.addArrangedSubview(plusView)
        
        let bonusBall = LottoBallView()
        bonusBall.configure(number: bonusNumber, ballType: .bonus)
        ballStackView.addArrangedSubview(bonusBall)
    }
    
    private func fetchLottoNumbers(round: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                self.winningNumbers = [
                    lotto.drwtNo1, lotto.drwtNo2, lotto.drwtNo3,
                    lotto.drwtNo4, lotto.drwtNo5, lotto.drwtNo6
                ]
                self.bonusNumber = lotto.bnusNo
                self.generateLottoNumbers()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}

extension LottoViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(inputTextView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(dateLabel)
        view.addSubview(labelStackView)
        view.addSubview(lineLabel)
        view.addSubview(roundResultLabel)
        view.addSubview(ballStackView)
    }
    
    func configureLayout() {
        inputTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(inputTextView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(labelStackView.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        roundResultLabel.snp.makeConstraints { make in
            make.top.equalTo(lineLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
        
        ballStackView.snp.makeConstraints { make in
            make.top.equalTo(roundResultLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(60)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}

extension LottoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(availableRounds[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRound = availableRounds[row]
        inputTextView.text = "\(selectedRound)"
        updateRoundResult(round: selectedRound)
    }
}

extension LottoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableRounds.count
    }
}
