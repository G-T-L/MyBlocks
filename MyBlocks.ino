//Name:		MyBlocks.ino

/***********************************************程序维护区*************************************************/
const int N = 8;//电机数
const int SpeedFactor = 1.0;//速度系数
const int Bottom = 30;//电机运动的底部
const int Middle = 500;//电机运动的中部
const int Top = 1000;//电机运动的顶部
const int Precision = 15;//运动的判定精度
const int MoveInterval = 120;//电机单次运动到某个目标位置的时长
const int BuzzerInterval = 100;//蜂鸣器单次通电时长
const int SpeedModificationInterval = 35;//速度系数调整的运动时长
const int InitializationTime = 1000;//初始化运动到目标位置的时间,要确保精度
const int LoopTime = 30000;//进入某个演示模式的持续时间
const int TimeDelay_WaitForStop = 50;//延时参数,等待系统稳定

/*************************************************   定义类   *************************************************/
//定义了个motor类,一般情况下只需直接调用.move(int location)函数来控制
//此函数只控制速度方向和大小,时间需另外控制
//也可循环调用,直至到达目标位置(速度为0)或时间到接收下一组数据;
//也提供.move(bool direction,int speed)具体控制速度和方向;
//还提供.stop()与.location()等供特殊使用
//遵循驼峰命名法,与adruino的库函数一样,便于记忆使用;

class motor
{
public:
	void motorSet(int pwm, int in1, int in2, int locpin);
	bool move(int destination);//向目标以一定的速度开始运动
	void move(bool i, int speed);
	int location();
	void stop();
	float u = SpeedFactor;//速度系数,也可调节阻力
private:
	void setDirection(bool i);
	int speed(int destination);
	int PWM, IN1, IN2, LocationPin;//记录引脚

};

void motor::motorSet(int pwm, int in1, int in2, int locpin)
{
	PWM = pwm;
	IN1 = in1;
	IN2 = in2;
	LocationPin = locpin;
}

int motor::location()
{
	return analogRead(LocationPin);
}

void motor::setDirection(bool i)
{
	if (i)
	{
		digitalWrite(IN1, HIGH);
		digitalWrite(IN2, LOW);
	}
	else
	{
		digitalWrite(IN1, LOW);
		digitalWrite(IN2, HIGH);
	}
}

int motor::speed(int destination)
{
	int speed;
	int distance = destination - location();
	if (distance >= 0)
		setDirection(1);
	else
		setDirection(0);
	distance = abs(distance);
	if (distance < Precision)//直接决定精度
	{
		speed = 0;
	}
	else if (distance < 50)
	{
		speed = 30 * u;
	}
	else if (distance < 100)
	{
		speed = 60 * u;
	}
	else if (distance < 300)
	{
		speed = 100 * u;
	}
	else if (distance < 600)
	{
		speed = 150 * u;
	}
	else if (distance < 1024)
	{
		speed = 200 * u;
	}
	else
		return 1;
	return speed;
}

bool motor::move(int destination)
{
	destination = constrain(destination, Bottom, Top);//限定运动区间
	analogWrite(PWM, constrain(speed(destination), 0, 255));
	if (abs(location() - destination) < 2 * Precision)//判定是否到位,调试用
		return true;
	else
		return false;
}

void motor::move(bool i, int speed)
{
	setDirection(i);
	analogWrite(PWM, speed);
}

void motor::stop()
{
	analogWrite(PWM, 0);
}

/******************************************   定义引脚与变量   *******************************************/
class motor motor[N];
int location[N];
long time;
int BUZZER = 48;//蜂鸣器引脚

int PWMA = 2;
int STBY0 = 3;
int PWMB = 4;
int PWMC = 5;
int STBY1 = 6;
int PWMD = 7;
int PWME = 8;
int STBY2 = 9;
int PWMF = 10;
int PWMG = 11;
int STBY3 = 12;
int PWMH = 13;

int AIN1 = 22;
int AIN2 = 24;
int BIN1 = 26;
int BIN2 = 28;
int CIN1 = 30;
int CIN2 = 32;
int DIN1 = 34;
int DIN2 = 36;
int EIN1 = 23;
int EIN2 = 25;
int FIN1 = 27;
int FIN2 = 29;
int GIN1 = 31;
int GIN2 = 33;
int HIN1 = 35;
int HIN2 = 37;

int LOCA = A0;
int LOCB = A1;
int LOCC = A2;
int LOCD = A3;
int LOCE = A4;
int LOCF = A5;
int LOCG = A6;
int LOCH = A7;

/***************************************   Setup 配置引脚模式 并进行必要的初始化  ****************************************/

void setup()
{
	pinMode(20, INPUT_PULLUP);//配置中断引脚
	pinMode(21, INPUT_PULLUP);//配置中断引脚
	attachInterrupt(20, locationGenerate_1_loop, FALLING);
	attachInterrupt(21, locationGenerate_2_loop, FALLING);
	pinMode(BUZZER, OUTPUT);
	pinMode(STBY0, OUTPUT);
	pinMode(AIN1, OUTPUT);
	pinMode(AIN2, OUTPUT);
	pinMode(PWMA, OUTPUT);
	pinMode(BIN1, OUTPUT);
	pinMode(BIN2, OUTPUT);
	pinMode(PWMB, OUTPUT);
	pinMode(STBY1, OUTPUT);
	pinMode(CIN1, OUTPUT);
	pinMode(CIN2, OUTPUT);
	pinMode(PWMC, OUTPUT);
	pinMode(DIN1, OUTPUT);
	pinMode(DIN2, OUTPUT);
	pinMode(PWMD, OUTPUT);
	pinMode(STBY2, OUTPUT);
	pinMode(EIN1, OUTPUT);
	pinMode(EIN2, OUTPUT);
	pinMode(PWME, OUTPUT);
	pinMode(FIN1, OUTPUT);
	pinMode(FIN2, OUTPUT);
	pinMode(PWMF, OUTPUT);
	pinMode(STBY3, OUTPUT);
	pinMode(GIN1, OUTPUT);
	pinMode(GIN2, OUTPUT);
	pinMode(PWMG, OUTPUT);
	pinMode(HIN1, OUTPUT);
	pinMode(HIN2, OUTPUT);
	pinMode(PWMH, OUTPUT);
	digitalWrite(STBY0, HIGH);
	digitalWrite(STBY1, HIGH);
	digitalWrite(STBY2, HIGH);
	digitalWrite(STBY3, HIGH);
	motor[0].motorSet(PWMA, AIN1, AIN2, LOCA);
	motor[1].motorSet(PWMB, BIN1, BIN2, LOCB);
	motor[2].motorSet(PWMC, CIN1, CIN2, LOCC);
	motor[3].motorSet(PWMD, DIN1, DIN2, LOCD);
	motor[4].motorSet(PWME, EIN1, EIN2, LOCE);
	motor[5].motorSet(PWMF, FIN1, FIN2, LOCF);
	motor[6].motorSet(PWMG, GIN1, GIN2, LOCG);
	motor[7].motorSet(PWMH, HIN1, HIN2, LOCH);
	Serial.begin(9600);
	for (int i = 0; i < N; i++)
		location[i] = Bottom;
	//调整速度系数u
	//speedModify_1();
	//delay(500);
	//speedModify_2();
	//delay(500);
	//speedModify_3();
	//delay(500);
	initialize_goto_bottom();//复位,准备开始
	
	while (!Serial){;}

}

void loop()
{
	Serial.println(6);//任意
	receive();
	time = millis();
	Serial1.println(millis());
	while (millis() - time < MoveInterval)
	{
		for (int i = 0; i < N; i++)
			motor[i].move(location[i]);
	}
}

void receive()
{ //读串口
	//Serial.println("recieve called");
	//当串口读取了N个数,或遇到'\n'则跳出结束读取
	int n;
	n = 0;
	location[N - 1] = 0;
	while (location[N - 1] == 0)
	{
		for (int i = 0; i < Serial.available(); i++)
		{
			if (Serial.peek() == ' ')
				Serial.read();
			if (Serial.peek() == '\n')
			{
				Serial.read();
				goto move;
			}
			location[n++] = Serial.parseInt();
		}
	}
	if (Serial.peek() == '\n')
		Serial.read();
move:;
}

//两个以不同方式单次产生目标位置的函数
void locationGenerate_1()
{ //随机数
	for (int i = 0; i < N; i++)
	{
		Serial.print(motor[i].move(location[i]));
	}
	Serial.println();
	for (int i = 0; i < N; i++)
	{
		location[i] = random(Bottom, Top);
	}
}

void locationGenerate_2()
{ //波浪
	static unsigned int j = 0;
	j++;
	for (int i = 0; i < N; i++)
		location[i] = ((i + j) * 100) % 1024;

}

//两个以不同方式不断产生目标位置并不断向其运动的函数
//此函数总的持续时间可在程序维护区通过更改LoopTime实现
void locationGenerate_1_loop()
{
	detachInterrupt(20);
	time = millis();
	while (millis() - time<LoopTime)
	{
		locationGenerate_1();
		long time2 = millis();
		while (millis() - time2 < MoveInterval)//设定执行时间
			for (int i = 0; i < N; i++)
				motor[i].move(location[i]);
	}
	initialize_goto_middle();
	attachInterrupt(20, locationGenerate_1_loop, FALLING);
}

void locationGenerate_2_loop()
{
	detachInterrupt(21);
	time = millis();
	while (millis() - time<LoopTime)
	{
		locationGenerate_2();
		long time2 = millis();
		while (millis() - time2 < MoveInterval)//设定执行时间
			for (int i = 0; i < N; i++)
				motor[i].move(location[i]);
	}
	initialize_goto_middle();
	attachInterrupt(21, locationGenerate_2_loop, FALLING);
}

//统一运动到底部(中间),初始化时可调用
void initialize_goto_bottom()
{
	buzzer_2();
	for (int i = 0; i < N; i++)
		location[i] = Bottom;
	time = millis();
	while (millis() - time < InitializationTime)//设定执行时间
	{
		for (int i = 0; i < N; i++)
			motor[i].move(location[i]);
	}
}

void initialize_goto_middle()
{
	buzzer_2();
	for (int i = 0; i < N; i++)
		location[i] = Middle;
	time = millis();
	while (millis() - time < InitializationTime)//设定执行时间
	{
		for (int i = 0; i < N; i++)
			motor[i].move(location[i]);
	}
}

//速度系数(阻力系数)调整(3种模式)
void speedModify_1()
{
	//从bottom开始向上运动一定时长,
	//模拟相邻都向上的运动情况
	//根据位置差异调整速度系数,去差异化
	//总的速度系数在最上面可调
	bool flag = 1;
	while (flag)
	{
		flag = 0;
		initialize_goto_bottom();
		delay(500);
		for (int i = 0; i < N; i++)
			if (!motor[i].move(Bottom))
				flag = 1;
	}
	for (int i = 0; i < N; i++)
		motor[i].move(1, 150);
	delay(2 * SpeedModificationInterval);//视情况在上面调整
	for (int i = 0; i < N; i++)
		motor[i].stop();
	delay(TimeDelay_WaitForStop);

	float average = 0;
	for (int i = 0; i < N; i++)
		average += motor[i].location();
	average /= N;
	for (int i = 0; i < N; i++)
		motor[i].u /= motor[i].location() / average;
	for (int i = 0; i < N; i++)
	{
		if (motor[i].u > 2)
			motor[i].u = 2;
		else if (motor[i].u < 0.5)
			motor[i].u = 0.5;
	}
}

void speedModify_2()
{
	//从中间开始运动一上一下的模式,模拟相邻反向的真实情况
	bool flag = 1;
	while (flag)
	{
		flag = 0;
		initialize_goto_middle();
		for (int i = 0; i < N; i++)
			if (!motor[i].move(500))
				flag = 1;
	}
	for (int i = 0; i < N; i += 2)//0,2,4,6,up
		motor[i].move(1, 150);
	for (int i = 1; i < N; i += 2)//1,3,5,7,down
		motor[i].move(0, 150);
	delay(SpeedModificationInterval);
	for (int i = 0; i < N; i += 2)//0,2,4,6,
		motor[i].stop();
	for (int i = 1; i < N; i += 2)//1,3,5,7
		motor[i].stop();
	delay(TimeDelay_WaitForStop);

	float ave1 = 0, ave2 = 0;
	for (int i = 0; i < N; i += 2)
		ave1 += motor[i].location();
	ave1 /= N / 2;
	for (int i = 0; i < N; i += 2)
		motor[i].u /= motor[i].location() / ave1;

	for (int i = 1; i < N; i += 2)
		ave2 += motor[i].location();
	ave2 /= N / 2;
	for (int i = 2; i < N; i += 2)
		motor[i].u *= motor[i].location() / ave2;
	for (int i = 0; i < N; i++)
	{
		if (motor[i].u > 2)
			motor[i].u = 2;
		else if (motor[i].u < 0.5)
			motor[i].u = 0.5;
	}
}

void speedModify_3()
{
	//从中间开始运动一上一下的模式,模拟相邻反向的真实情况
	//与speedModify_2类似,只是奇偶数运动情况互换
	bool flag = 1;
	while (flag)
	{
		flag = 0;
		initialize_goto_middle();
		for (int i = 0; i < N; i++)
			if (!motor[i].move(500))
				flag = 1;
	}
	for (int i = 0; i < N; i += 2)//0,2,4,6,dowm
		motor[i].move(0, 150);
	for (int i = 1; i < N; i += 2)//1,3,5,7,up
		motor[i].move(1, 150);
	delay(SpeedModificationInterval);//运动时间
	for (int i = 0; i < N; i += 2)//0,2,4,6,
		motor[i].stop();
	for (int i = 1; i < N; i += 2)//1,3,5,7
		motor[i].stop();
	delay(TimeDelay_WaitForStop);

	float ave1 = 0, ave2 = 0;
	for (int i = 0; i < N; i += 2)
		ave1 += motor[i].location();
	ave1 /= N / 2;
	for (int i = 0; i < N; i += 2)
		motor[i].u *= motor[i].location() / ave1;

	for (int i = 1; i < N; i += 2)
		ave2 += motor[i].location();
	ave2 /= N / 2;
	for (int i = 2; i < N; i += 2)
		motor[i].u /= motor[i].location() / ave2;

	for (int i = 0; i < N; i++)
	{
		if (motor[i].u > 2)
			motor[i].u = 2;
		else if (motor[i].u < 0.5)
			motor[i].u = 0.5;
	}
}

void buzzer_1()
{
	digitalWrite(BUZZER, HIGH);
	delay(BuzzerInterval);
	digitalWrite(BUZZER, LOW);
	delay(BuzzerInterval);
}

void buzzer_2()
{
	buzzer_1();
	buzzer_1();
}

void buzzer_3()
{
	buzzer_1();
	buzzer_1();
	buzzer_1();
}

void moveToMiddleOneByOne()//one by one
{
	long time = millis();
	for (int i = 0; i < N; i++)
	{
		while (millis() - time < 500)
		{
			motor[i].move(500);
		}
		time = millis();
	}
}
