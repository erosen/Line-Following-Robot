// Arduino Language Reference
// http://arduino.cc/en/Reference/HomePage

#define motor1Dir 7
#define motor2Dir 8
#define motor1PWM 9
#define motor2PWM 10
#define motor1Enable 11
#define motor2Enable 12



void setMotorVel(int dirPin, int pwmPin, int velocity){
  if (velocity >= 255) velocity = 255;
  if (velocity <= -255) velocity = -255;

  if (velocity == 0)
  {
    digitalWrite(dirPin, HIGH);
    digitalWrite(pwmPin, HIGH);
  }
  else if(velocity <0){  // Reverse
    digitalWrite(dirPin, HIGH);
    analogWrite(pwmPin, 255+velocity);
  }
  else if(velocity >0){ // Forward
    digitalWrite(dirPin,LOW);
    analogWrite(pwmPin, velocity);
  }
}


void setLeftMotorSpeed(int velocity)
{
  setMotorVel(motor1Dir, motor1PWM, -velocity);

}

void setRightMotorSpeed(int velocity){
  setMotorVel(motor2Dir, motor2PWM, -velocity);
}

void initMotorDriver()
{
  pinMode(motor1Dir, OUTPUT);
  pinMode(motor2Dir, OUTPUT);

  pinMode(motor1Enable, OUTPUT);
  pinMode(motor2Enable, OUTPUT);
  digitalWrite(motor1Enable,HIGH);
  digitalWrite(motor2Enable,HIGH);
  setLeftMotorSpeed(0); // make sure the motors are stopped
  setRightMotorSpeed(0);
}




void goForward()
{
  setLeftMotorSpeed(255);
  setRightMotorSpeed(255);
}

void goRight()
{
  setLeftMotorSpeed(255);
  setRightMotorSpeed(-255);
}

void goLeft()
{
  setLeftMotorSpeed(-255);
  setRightMotorSpeed(255);
}


void setup(){
  Serial.begin(115200); //Set the buad rate for the serial com. 

  // prints title with ending line break 
  Serial.println("Line Sensor boar Sensor test"); 
  initMotorDriver();
  
  
}


#define line_thresh 100


void loop(){
 int sensors[5];

 for (int i =0; i <5; i++)
  {
    sensors[i] = analogRead(i);
  }

  Serial.print("Sensor Values : " );

  for (int i =0; i <4; i++)
  {
    Serial.print( sensors[i]);
    Serial.print(" " );
  }

  Serial.println(" ");

  if(( sensors[3] < line_thresh) || (sensors[4] <line_thresh))  // 250 is a measured threshold between white & black
  {
    goLeft();
    delay(30);
  }
   else if(( sensors[0] <line_thresh) || (sensors[1] <line_thresh))
  {
    goRight();
    delay(30);
  }
  else{
  goForward();
  
  delay(100);
  }
  
  
}
