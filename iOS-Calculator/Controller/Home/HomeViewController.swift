//
//  HomeViewController.swift
//  iOS-Calculator
//
//  Created by Diego Rodrigues on 02/03/23.
//

import UIKit

final class HomeViewController: UIViewController {

    // Resultado
    @IBOutlet weak var resultLabel: UILabel!
    
    //Numeros
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    // Operadores
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operadorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operadorResult: UIButton!
    @IBOutlet weak var operadorAddition: UIButton!
    @IBOutlet weak var operadorSubstraction: UIButton!
    @IBOutlet weak var operadorMultiplication: UIButton!
    @IBOutlet weak var operadorDivision: UIButton!
    
    //Variaveis
    
    private var total: Double = 0                       //Total
    private var temp: Double = 0                        //Valor por Tela
    private var operating = false                       //indique se um operador foi selecionado
    private var decimal = false                         //indique se o valor é decimal
    private var operation: OperationType = .none       //Operação atual
    
    // Constantes
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let KMinValue: Double = 999999999
    private let kMaxvalue: Double = 0.00000001
    
    private enum OperationType {
        case none, addiction, substraction, multiplication, division, percent
    }
    
    //Formatação de valor auxiliar
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // Formatação padrão de valores por tela
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Inicialização
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()

        operatorAC.round()
        operadorPlusMinus.round()
        operatorPercent.round()
        operadorResult.round()
        operadorAddition.round()
        operadorSubstraction.round()
        operadorMultiplication.round()
        operadorDivision.round()
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        result()
    }

    //Acões
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        
        temp = temp * (-1)
        
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        sender.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent {
            result()
        }
        operating = true
        operation = .percent
        result()
        sender.shine()
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
        sender.shine()
    }
    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        
        result()
        operating = true
        operation = .addiction
        
        sender.shine()
    }
    
    @IBAction func operatorSubractionAction(_ sender: UIButton) {
        
        result()
        operating = true
        operation = .substraction
        
        sender.shine()
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        
        result()
        operating = true
        operation = .multiplication
        
        sender.shine()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        
        result()
        operating = true
        operation = .division
        
        sender.shine()
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {

        let currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count > kMaxLength {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        decimal = true
        sender.shine()

    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        sender.shine()
        
        operatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count > kMaxLength {
            return
        }
        
        //selecionamos uma operação
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        //selecionando decimal
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        print(sender.tag)
        
        sender.shine()
    }
    
    // Limpe seus Valores
    private func clear() {
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
        }
    }
        // Obtém o resultado final
        private func result() {
            
            switch operation {
            case .none:
                //não fazemos nada
                break
            case .addiction:
                total = total + temp
                break
            case .substraction:
                total = total - temp
                break
            case .multiplication:
                total = total * temp
                break
            case .division:
                total = total / temp
                break
            case .percent:
                total = total / 100
                total = temp
                break
        }
            
            //Formataçào da tela
            if total < kMaxvalue || total > KMinValue {
                resultLabel.text = printFormatter.string(from: NSNumber(value: total))
            }
            
            print("Total: \(total)")
    }
}
