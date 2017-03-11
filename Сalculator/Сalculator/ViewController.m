//
//  ViewController.m
//  Сalculator
//
//  Created by Serik Klement on 06.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *first;
@property (strong, nonatomic) NSString *second;
@property (strong, nonatomic) NSString *sign;
@property (assign, nonatomic) BOOL finichFirst;
@property (assign, nonatomic) CGFloat result;

@end

@implementation ViewController

// не реализованы:
// действия при высичлением со знаком "-"
// следующее вычисление т.е. вычисление с полученным  результатом, без обнуления
// работа с "," - вычисления и результаты

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reset]; // задаю начальные значения пропертям и вызываем в методе
    
    UILabel *label = [self createLabel]; // вызываю метод создания label
    [self.view addSubview:label]; // добавляю label на view
    
    NSArray *arrayButton = [NSArray arrayWithObjects:@"C", @"+/-", @"%", @"/", @"7", @"8", @"9", @"*", @"4", @"5", @"6", @"-", @"1", @"2", @"3", @"+", @"0", @"00", @",", @"=", nil]; // создаю массив строк в порядке создания кнопок
    
    NSInteger count = 0; // создаю переменную count с значением 0
    
    for (NSInteger row = 1; row <= 5; row++) { // создаю цикл 5 РЯДОВ, с 1 чтоб
        
        for (NSInteger column = 1; column <= 4; column++) { // создаю цикл в цикле 4 КОЛОНКИ, с 1 чтоб
            
            UIButton *button = [self createButton]; // в цикле вызываю метод создания кнопки
            button.center = CGPointMake(button.frame.size.width * column - button.frame.size.width / 2, button.frame.size.height * row + 170); // выстраиваю кнопки по центру
            [button setTitle:[arrayButton objectAtIndex:count] forState:UIControlStateNormal]; // присваиваю индексу объекту масссива значение count
            
            [self defaultButton:count andButton:button]; // вызываю метод дефолтных настроек цвета
            
            count++; // увеличиваю count на 1 чтоб в цикле при след. проходе count записал в tag следующее значение
            
            [self.view addSubview:button]; // добавляю на view указатель tempButton
        }
    }
    
}

- (UILabel*) createLabel { // метод создания label
    
    UILabel *label = [UILabel new]; // создаю объект label
    label.frame = CGRectMake(0, 82, self.view.frame.size.width, 130); // задаю frame
    label.layer.borderWidth = 1; // толщина линии
    label.layer.borderColor = [[UIColor blackColor] CGColor]; // цвет линии
    label.tag = 17; // задаю tag
    label.textAlignment = NSTextAlignmentRight; // положение текста
    label.font = [UIFont systemFontOfSize:80]; // размер текста
    label.textColor = [UIColor whiteColor]; // цвет текста
    label.backgroundColor = [UIColor colorWithRed:148.0/255 green:145.0/255 blue:146.0/255 alpha:1]; // цвет label
    label.text = [NSString stringWithFormat:@"0"];
    
    return label;
    
}

- (UIButton*) createButton { // метод создания button
    
    UIButton *button = [[UIButton alloc] init]; // создаю button
    CGFloat width = self.view.frame.size.width / 4; // ширина button
    button.frame = CGRectMake(0, 0, width, width - 20); // задаю frame
    button.layer.borderWidth = 1; // толщина линии
    button.layer.borderColor = [[UIColor blackColor] CGColor]; // цвет линий + конвертация в CGColor
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // цвет шрифта
    button.backgroundColor = [UIColor colorWithRed:215.0/255 green:211.0/255 blue:213.0/255 alpha:1]; // цвет button
    button.titleLabel.font = [UIFont systemFontOfSize:50]; // размер текста
    
    [button addTarget:self action:@selector(touchDownButton:) forControlEvents:UIControlEventTouchDown]; // вызываю метод при нажатия
    
    [button addTarget:self action:@selector(actionUpInsideButton:) forControlEvents:UIControlEventTouchUpInside]; // вызываю метод при отпускании
    
    return button; // addTarget - задаю действие при нажитии (UIControlEventTouchUpInside)
    
}

#pragma mark - TouchButton

- (void) defaultButton:(NSInteger) count andButton:(UIButton*) defButton { // возвращение дефолтных настроек - условия цветов для отпускание
    
    defButton.tag = count; // присваиваем проперти tag переменную count
    
    if (defButton.tag == 1 || // выбираю кнопки по tag
        defButton.tag == 2 ||
        defButton.tag == 3 ||
        defButton.tag == 7 ||
        defButton.tag == 11 ||
        defButton.tag == 15 ||
        defButton.tag == 19) {
        
        defButton.backgroundColor = [UIColor colorWithRed:255.0/255 green:147.0/255 blue:47.0/255 alpha:1]; // присваиваю цвета кнопкам по tag в состоянии покоя - оранжевый
        [defButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; // присваиваю цвет надписи по tag в состоянии покоя
        
    } else if (defButton.tag == 0) {
        
        defButton.backgroundColor = [UIColor colorWithRed:163.0/255 green:55.0/255 blue:64.0/255 alpha:1];// - красный
        [defButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    } else {
        
        defButton.backgroundColor = [UIColor colorWithRed:215.0/255 green:211.0/255 blue:213.0/255 alpha:1]; // цвет button при нажатии
    }
    
}

- (void) touchDownButton:(UIButton*) downButton  { // условия цветов для нажатия
    
    if (downButton.tag == 1 || // выбираю кнопки по tag
        downButton.tag == 2 ||
        downButton.tag == 3 ||
        downButton.tag == 7 ||
        downButton.tag == 11 ||
        downButton.tag == 15 ||
        downButton.tag == 19) {
        
        downButton.backgroundColor = [UIColor colorWithRed:255.0/255 green:147.0/255 blue:47.0/255 alpha:0.5]; // присваиваю цвета кнопкам по tag в состоянии покоя - светло-оранжевый
        [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; // присваиваю цвет надписи по tag в состоянии покоя
        
    } else if (downButton.tag == 0) {
        
        downButton.backgroundColor = [UIColor colorWithRed:163.0/255 green:55.0/255 blue:64.0/255 alpha:0.5]; // - светло-красный
        [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    } else {
        
        downButton.backgroundColor = [UIColor colorWithRed:215.0/255 green:211.0/255 blue:213.0/255 alpha:0.5]; // цвет button при нажатии
        
    }
    
}

#pragma mark - Action

- (void) actionUpInsideButton:(UIButton*) sender { // метод при нажатии на кнопка
    
    NSInteger count = sender.tag;
    
    [self defaultButton:count andButton:sender]; // вызываю метод опускания кнопки
    
    UILabel *label = [self.view viewWithTag:17]; // присваиваю указателю newLabel label с tag 17, найденым на супервью
    
    if ([sender.currentTitle isEqualToString:@"+"] ||  // сверяю 2 строки
        [sender.currentTitle isEqualToString:@"-"] ||
        [sender.currentTitle isEqualToString:@"*"] ||
        [sender.currentTitle isEqualToString:@"/"]) {
        
        self.sign = sender.currentTitle; // записываю в проперти надпись кнопки
        self.finichFirst = YES; // меняю значение проперти
        
        return; // выходим
        
    }
    
    if ([sender.currentTitle isEqualToString:@"="]) { // если надпись "="
        
        if (self.finichFirst == YES) { // если был нажат символ вычисление
            
            [self calculationResult:sender]; // вызываю метод считать
            
        } else {
            
            if ([label.text isEqual:@"0"]) { // если не было вычислений
                
                label.text = @"0";
                
            } else {
                
                label.text = self.first;
                
            }
            
        }
        
        return;
        
    }
    
    if ([sender.currentTitle isEqualToString:@"%"]) { // если надпись "%"
        
        [self calculationResult:sender]; // вызываю метод считать
        
        return;
        
    }
    
    if ([sender.currentTitle isEqualToString:@"C"]) { // если надпись "С"
        
        [self reset]; // вызываю метод обнуления
        
        label.text = @"0"; // обнуляю лейбл (стринг)
        
        return;
    }
    
    if (self.finichFirst == NO) { // если булевая переменная равна NO - нет результата
        
        if ([sender.currentTitle isEqualToString:@"+/-"]) { // если надпись "+/-"
            
            NSString *string = label.text;
            
            NSRange range = [string rangeOfString:@"-"]; // структура. нахожу range -
            
            if (range.location != NSNotFound) { // если есть -
                
                string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""]; // убираю -
                
                label.text = string;
                
            } else { // если нет -
                
                NSString *string = @"-";
                
                label.text = [string stringByAppendingString:label.text];
                
            }
            
        } else {
            
            self.first = [self.first stringByAppendingString:sender.currentTitle]; // добавляю к строке self.first новую строку sender.currentTitle когда пишим многозначное число на калькуляторе
            
            label.text = self.first; // передаю в label текст надписи на button из проперти
            
        }
        
    } else { // если булевая переменная равна YES - есть результат
        
        self.second = [self.second stringByAppendingString:sender.currentTitle];
        
        label.text = self.second;
        
    }
    
}

#pragma mark - Result

- (void) calculationResult:(UIButton*) sender  { // расчёты
    
    CGFloat firstNumber = [self.first doubleValue]; // создаю firstNumber и переводим string  в double
    CGFloat secondNumber = [self.second doubleValue]; // создаю secondNumber и переводим string  в double
    
    if ([sender.currentTitle isEqualToString:@"%"]) {
        
        if ([self.sign isEqualToString:@"*"]) { // если в проперти sign "*"
            
            self.result = (firstNumber / 100) * secondNumber;
            
        }
        
    } else {
        
        if ([self.sign isEqualToString:@"-"]) { // если в проперти sign "-"
            
            self.result = firstNumber - secondNumber; // тогда вычитаю из firstNumber, secondNumber
            
        } else if ([self.sign isEqualToString:@"+"]) { // если в проперти sign "+"
            
            self.result = firstNumber + secondNumber; // тогда сумирую из firstNumber, secondNumber
            
        } else if ([self.sign isEqualToString:@"*"]) { // если в проперти sign "*"
            
            self.result = firstNumber * secondNumber; // тогда умножаю firstNumber на secondNumber
            
        } else if ([self.sign isEqualToString:@"/"]) { // если в проперти sign "/"
            
            self.result = firstNumber / secondNumber; // тогда делю firstNumber на secondNumber
            
        }
    }
    
    UILabel *label = [self.view viewWithTag:17]; // присваиваю указателю newLabel label с tag 17, найденым на супервью self.view
    
    label.text = [NSString stringWithFormat:@"%.f", self.result]; // преобразовал CGFloat в NSString и вывел
    
    [self reset]; // обнулил пропертри
    
}

- (void) reset { // обнуляю проперти или начальное значение
    
    self.first = @""; // задаю пустую строку в проперти первого числа
    self.second = @"";
    self.finichFirst = NO;
    self.sign = @"";
    self.result = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
