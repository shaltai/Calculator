import UIKit

class CalculatorViewController: UIViewController {
    
    enum Operation: String {
        case divide
        case multiply
        case minus
        case plus
    }
    
    var workings: [Int] = []
    var firstNumber: Double?
    var secondNumber: Double?
    var currentNumber: Double { Double(workings.reduce(0, { $0 * 10 + $1 })) }
    var currentOperation: Operation?
    var memory = 0.0
    var isPressed = false
    
    @IBOutlet weak var workingsLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var memoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Operation
    
    private func operation() {
        
        func formatNumber() {
            let intFirstNumber = Int(firstNumber!)
            let decimalFirstNumber = firstNumber! - Double(intFirstNumber)
            if decimalFirstNumber == 0 {
                resultLabel.text = String(intFirstNumber)
            } else {
                resultLabel.text = String(firstNumber!)
            }
        }
        
        switch currentOperation{
        case .plus:
            firstNumber! += secondNumber!
            formatNumber()
        case .minus:
            firstNumber! -= secondNumber!
            formatNumber()
        case .multiply:
            firstNumber! *= secondNumber!
            formatNumber()
        case .divide:
            if secondNumber == 0 {
                resultLabel.text = "Can't devide by 0"
            } else {
                firstNumber! /= secondNumber!
                formatNumber()
            }
        default:
            break
        }
    }
    
    //MARK: Clear
    @IBAction func clearButton(_ sender: Any) {
        workingsLabel.text = ""
        resultLabel.text = "0"
        workings = []
        firstNumber = nil
        secondNumber = nil
        isPressed = false
    }
    
    //MARK: Plus/Minus
    @IBAction func plusMinusButton(_ sender: Any) {
        
        if workingsLabel.text?.first != "–" {
            workingsLabel.text! = "–" + workingsLabel.text!
            workings = workings.map( {-$0} )
        } else {
            workingsLabel.text!.removeFirst()
            workings = workings.map( {-$0} )
        }
    }
    
    //MARK: Percent
    @IBAction func percentButton(_ sender: Any) {
        
        secondNumber = firstNumber! / 100 * currentNumber
        workings = []
        
        workingsLabel.text! = String(secondNumber!)
        
        operation()
    }
    
    //MARK: Operators
    @IBAction func operatorButton(_ sender: UIButton) {
        
        switch sender.tag {
        
        //Plus
        case 12:
            if firstNumber == nil && isPressed == false {
                
                workingsLabel.text! += "+"
                firstNumber = currentNumber
                workings = []
                
            } else if workings.isEmpty == false {
                
                workingsLabel.text! += "+"
                secondNumber = currentNumber
                workings = []
                operation()
                isPressed = true
                
            } else {
                
                isPressed = false
                return
                
            }
            currentOperation = Operation.plus
            
        //Minus
        case 13:
            if firstNumber == nil && isPressed == false {
                
                workingsLabel.text! += "-"
                firstNumber = currentNumber
                workings = []
                
            } else if workings.isEmpty == false {
                
                workingsLabel.text! += "-"
                secondNumber = currentNumber
                workings = []
                operation()
                isPressed = true
                
            } else {
                
                isPressed = false
                return
                
            }
            currentOperation = Operation.minus
            
        //Multiply
        case 14:
            if firstNumber == nil && isPressed == false {
                
                workingsLabel.text! += "×"
                firstNumber = currentNumber
                workings = []
                
            } else if workings.isEmpty == false {
                
                workingsLabel.text! += "×"
                secondNumber = currentNumber
                workings = []
                operation()
                isPressed = true
                
            } else {
                
                isPressed = false
                return
                
            }
            currentOperation = Operation.multiply
            
        //Divide
        case 15:
            if firstNumber == nil && isPressed == false {
                
                workingsLabel.text! += "÷"
                firstNumber = currentNumber
                workings = []
                
            } else if workings.isEmpty == false {
                
                workingsLabel.text! += "÷"
                secondNumber = currentNumber
                workings = []
                operation()
                isPressed = true
                
            } else {
                
                isPressed = false
                return
                
            }
            currentOperation = Operation.divide
            
        //MARK: Equal
        case 11:
//            if isPressed == true {
//                operation()
//            } else {
//                secondNumber = currentNumber
//                workings = []
//                operation()
//                isPressed = true
//            }
            secondNumber = currentNumber
            workings = []
            operation()
            isPressed = true
        default:
            break
        }
    }
    
    @IBAction func decimalButton(_ sender: Any) {
        workingsLabel.text! += ","
        
    }
    
    //MARK: Digits
    @IBAction func digitButton(_ sender: UIButton) {
        let tag = sender.tag
        
        workings.append(tag)
        workingsLabel.text! += String(tag)
        
        if workings.count > 1 {
            
            if workings[0] == 0 && workings[1] == 0 {
                
                workings = [0]
                workingsLabel.text!.removeAll(where: { $0 == "0" })
                
            } else if workings[0] == 0 && workings[1] != 0 {
                
                workings.removeFirst()
                workingsLabel.text!.removeAll(where: { $0 == "0" })
            }
        }
    }
    
    //MARK: Memory
    @IBAction func memoryButtons(_ sender: UIButton) {
        
        switch sender.tag {
        case 30:
            workingsLabel.text = ""
            memoryLabel.text = ""
            memory = 0.0
        case 31:
            memory += currentNumber
            workings = []
            workingsLabel.text = ""
            memoryLabel.text = "M"
        case 32:
            memory -= currentNumber
            workings = []
            workingsLabel.text = ""
            memoryLabel.text = "M"
        case 33:
            resultLabel.text = String(memory)
        default:
            break
        }
        
    }
    
    
}
