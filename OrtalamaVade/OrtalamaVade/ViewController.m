//
//  ViewController.m
//  OrtalamaVade
//
//  Created by Bekir Yaylacı on 18.04.2016.
//  Copyright © 2016 Bekir Yaylacı. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



float ver_space=60.0,dateTextBoxXCoordinate = 274.0,dateTextBoxYCoordinate=240.0;
int dTag=1,dTags=1,pTag=1,pTags=1;
float ortVade = 0.0;
float datePicklerYCoordinate = 330.0,datePicklerXCoordinate = 274.0, lblSumXCoordinate = 464.0,lblSumYCoordinate = 250.0;
UITextField *textField;
UITextField *textFieldPrice;
UIDatePicker *datePicker;
UILabel *lblSum;
@synthesize view1;
@synthesize lblOrtVadeTarihi;
@synthesize lblOrtVadeTutari;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    ver_space=60.0,dateTextBoxXCoordinate = 274.0,dateTextBoxYCoordinate=240.0;
    dTag=1,dTags=1,pTag=1,pTags=1;
    ortVade = 0.0;
    datePicklerYCoordinate = 330.0,datePicklerXCoordinate = 274.0, lblSumXCoordinate = 464.0,lblSumYCoordinate = 250.0;
    
    
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(datePicklerXCoordinate, datePicklerYCoordinate,250, 150)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    //datePicker.locale== [[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"];
    datePicker.hidden=NO;
    datePicker.locale = [NSLocale currentLocale];
    [datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    
    
    NSString *currencySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSLog(currencySymbol);
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"tr"];
    
    
    
    
    datePicker.date=[NSDate date];
    [datePicker addTarget:self action:@selector(getDate) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem=rightBtn;
    // Do any additional setup after loading the view, typically from a nib.
    
    [datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    [datePicker setHidden:YES];
    
    
    [self addLabelAndTextBox:dTag :pTag];
    
    lblSum = [[UILabel alloc]initWithFrame:CGRectMake(lblSumXCoordinate, lblSumYCoordinate, 100, 150) ];
    [lblSum setText:@"Toplam:"];
    [lblSum setTextColor:[UIColor whiteColor]];
    [self.view addSubview:lblSum];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [datePicker setHidden:YES];
    
}
-(IBAction)touchText1:(UITextField*)sender {
    
    [datePicker setHidden:NO];
    dTags = sender.tag;
}
-(IBAction)PriceTouchText1:(UITextField*)sender {
  

   
    [datePicker setHidden:YES];
    
    
}
-(IBAction)PriceEdited:(UITextField*)sender {
    int i=1;
    NSString *str;
    
    NSRange *range;
    double priceSum = 0.0;
    
    for (i=1;i<=dTag;i++){
        UITextField *priceFields = (UITextField*)[self.view viewWithTag:i+10];
        
        
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.numberStyle = NSNumberFormatterCurrencyStyle; //also tested with NSNumberFormatterDecimalStyle
        
        [formatter setCurrencyCode:@"₺"];
        [formatter setNegativeFormat:@"-¤#,##0.00"];
        double d = [formatter numberFromString:priceFields.text].floatValue;
        
        NSLog(priceFields.text);
        
        
        priceSum += d;
        //1[self convert:priceFields shouldChangeCharactersInRange:*range replacementString:str];
        
        
        
    }
    [lblSum setText:[NSString stringWithFormat:@"Toplam: %.02f",priceSum]];
}


-(IBAction)getDate{
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *dates = [dateFormat stringFromDate:datePicker.date];
    NSDate *chosen = [datePicker date];
    
    UITextField *textFields = (UITextField*)[self.view viewWithTag:dTags];
    
    NSLog(@"%@",chosen);
    [textFields setText:dates];
    
    
}

-(IBAction)addRow{
    
    UITextField *textFields = (UITextField*)[self.view viewWithTag:dTag];
    UITextField *priceFields = (UITextField*)[self.view viewWithTag:pTag+10];
    
    if ([textFields hasText] && [priceFields hasText]){
    dTag++;
    pTag++;
    
    
    if (dTag <12){
            lblSumYCoordinate += ver_space;
        if ( dTag < 8 ){
            datePicklerYCoordinate +=ver_space;
            
        }else{
        datePicklerXCoordinate = 40;
        }
        [self addLabelAndTextBox:dTag:pTag];
       
        
    [datePicker setFrame:CGRectMake( datePicklerXCoordinate, datePicklerYCoordinate, 250,150)];
    [lblSum setFrame:CGRectMake( lblSumXCoordinate, lblSumYCoordinate, 250,150)];
    }
    }
    
    
    
    
}

-(void) addLabelAndTextBox:(NSInteger *) dateTag :(NSInteger*) priceTag{
    
    
    
   
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(dateTextBoxXCoordinate, dateTextBoxYCoordinate                                                                        , 155, 50)];
    
    
    textField.tag = dateTag;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textField.adjustsFontSizeToFitWidth = TRUE;
    [textField addTarget:self action:@selector(touchText1:) forControlEvents:UIControlEventAllEvents];
    
    [datePicker setHidden:NO];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:19];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    //textField.keyboardType = UIKeyboardTypeDefault;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textField.returnKeyType = UIReturnKeyDone;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField becomeFirstResponder];//Focus to textfield
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:textField];
   
    
    textFieldPrice = [[UITextField alloc] initWithFrame:CGRectMake(dateTextBoxXCoordinate+180, dateTextBoxYCoordinate                                                                        , 155, 50)];
   NSLog([NSString stringWithFormat:@"%d",priceTag]);
    NSInteger price = priceTag;
    price +=10;
    NSLog([NSString stringWithFormat:@"%d",price]);
    textFieldPrice.tag = price;
    textFieldPrice.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textFieldPrice.adjustsFontSizeToFitWidth = TRUE;
    [textFieldPrice addTarget:self action:@selector(PriceTouchText1:) forControlEvents:UIControlEventAllEditingEvents];
    [textFieldPrice addTarget:self action:@selector(PriceEdited:) forControlEvents:UIControlEventEditingDidEnd];
    [textFieldPrice addTarget:self action:@selector(convert:shouldChangeCharactersInRange:replacementString:) forControlEvents:UIControlEventEditingChanged];

    
    
    [datePicker setHidden:NO];
    textFieldPrice.borderStyle = UITextBorderStyleRoundedRect;
    textFieldPrice.font = [UIFont systemFontOfSize:19];
    textFieldPrice.autocorrectionType = UITextAutocorrectionTypeNo;
    //textField.keyboardType = UIKeyboardTypeDefault;
    
    textFieldPrice.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textFieldPrice.returnKeyType = UIReturnKeyDone;
    textFieldPrice.textAlignment = NSTextAlignmentCenter;
    textFieldPrice.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldPrice.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:textFieldPrice];
    
    dateTextBoxYCoordinate += ver_space;
    
   
       /* UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(xCoordinate,yCoordinate,width,height)];
        //label.text = [dataArray objectAtIndex:i];
        
        label.text =  [NSString stringWithFormat:@"%d",i];
        
        [self.view addSubview:label];
        
        yCoordinate=yCoordinate+height+ver_space;*/
   
    
    
}


-(IBAction)getAllData{
    double priceSum = 0.0;
    int differDay=0;
    float price = 0,calcPrice =0 ,sumCalcPrice=0;
    ortVade = 0;
    
    int i=1,division=0;
    
    for (i=1;i<=dTag;i++){
    UITextField *textFields = (UITextField*)[self.view viewWithTag:i];
    UITextField *priceFields = (UITextField*)[self.view viewWithTag:i+10];
       
        
       
        
       
        if(([priceFields hasText]) && ([textFields hasText])){
            differDay = [self dateDiffer:textFields.text];
             NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
            formatter.locale = [NSLocale currentLocale];
            formatter.numberStyle = NSNumberFormatterCurrencyStyle; //also tested with NSNumberFormatterDecimalStyle
            
            [formatter setCurrencyCode:@"₺"];
            [formatter setNegativeFormat:@"-¤#,##0.00"];
            double d = [formatter numberFromString:priceFields.text].floatValue;
            
            ortVade += d;
            
            
            price = d;
            calcPrice = differDay * price ;
            sumCalcPrice += calcPrice;
            priceSum +=price;
            division++;
            
        }
    }
    [lblSum setText:[NSString stringWithFormat:@"Toplam: %.02f",priceSum]];
    
    NSDate *today=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components=[[NSDateComponents alloc] init];
   
    components.day= sumCalcPrice / ortVade;
    
    NSDate *targetDate =[calendar dateByAddingComponents:components toDate:today options: 0];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    [lblOrtVadeTarihi setHidden:NO];
    [lblOrtVadeTarihi setText:[dateFormat stringFromDate:targetDate]];
    [lblOrtVadeTutari setHidden:NO];
    [lblOrtVadeTutari setText:[NSString stringWithFormat:@"%0.02f",ortVade/(division)]];
    /*UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%.02f",sumCalcPrice / ortVade] delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];*/
    
    
    
}
-(NSInteger)dateDiffer:(NSString *)date{
    int monthToDay = 0;
    int yearToDay = 0;
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dateA = [dateFormat dateFromString:date];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    NSDate *dateB = [dateFormat dateFromString:string];
    
   
    NSInteger difference = [self numberOfDaysUntil:dateA:dateB];
   
    return difference;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfDaysUntil:(NSDate *)aDate :(NSDate *)bDate{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:bDate toDate:aDate options:0];
    
    return [components day];
}

- (BOOL)convert:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *cleanCentString = [[textField.text
                                  componentsSeparatedByCharactersInSet:
                                  [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                 componentsJoinedByString:@""];
    // Parse final integer val
    NSInteger centAmount = cleanCentString.integerValue;
    // Check the user input
    if (string.length > 0)
    {
        // Digit added
        centAmount = centAmount * 10 + string.integerValue;
    }
    else
    {
        // Digit deleted
        centAmount = centAmount ;
    }
    // Update call amount value
    NSNumber *amount = [[NSNumber alloc] initWithFloat:(float)centAmount / 100.000f];
    // Write amount with currency symbols to the textfield
    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_currencyFormatter setCurrencyCode:@"₺"];
    [_currencyFormatter setNegativeFormat:@"-¤#,##0.0"];
    textField.text = [_currencyFormatter stringFromNumber:amount];
    NSLog(textField.text);
    return NO; }


-(IBAction)newPage{
  
    [self viewDidLoad];
    [self.view setNeedsDisplay];
    
    
}
@end
