#include <iostream>
using namespace std;

class Animal
{
protected:
	const char *name;

public:
	Animal() :name(NULL) {}
	Animal(const char  *n) :name(n) {}
	~Animal() { delete name;}
	virtual void WhoAmI() { cout << "generic animal." << endl; };
};

class Cat:public Animal
{
public:
	Cat() :Animal() {}
	Cat(const char *n) :Animal(n) {}
	void WhoAmI() { cout << "I am a cat named " << name << endl; }
};

class Dog:public Animal
{
public:
	Dog():Animal() {}
	Dog(const char *n):Animal(n) {}
	void WhoAmI() { cout << "I am a dog named " << name << endl; }
};

class Pig:public Animal
{
public:
	Pig() :Animal() {}
	Pig(const char *n) :Animal(n) {}
	void WhoAmI() { cout << "I am a pig named " << name << endl; }
};

class Kennel
{
private:
	unsigned MaxAnimals, NumAnimals;
	Animal * *Residents;

public:
	Kennel(unsigned max);
	~Kennel() { delete Residents; }
	unsigned Accept(Animal *d);
	Animal *Release(unsigned pen);
	void ListAnimals();
};

Kennel::Kennel(unsigned max)
{
	MaxAnimals = max;
	NumAnimals = 0;
	Residents = new Animal *[MaxAnimals];
	for (unsigned i = 0; i < MaxAnimals; i++)
		Residents[i] = NULL;
}

//进笼
unsigned Kennel::Accept(Animal *d)
{
	if (NumAnimals == MaxAnimals)
		return 0;
	++NumAnimals;
	int i = 0;
	while (Residents[i] != NULL)
		++i;
	Residents[i] = d;
	return i+1;
}

//出笼
Animal *Kennel::Release(unsigned pen)
{
	if (pen > MaxAnimals)
		return NULL;
	--pen;
	if (Residents[pen] != NULL)
	{
		Animal *temp = Residents[pen];
		Residents[pen] = NULL;
		--NumAnimals;
		return temp;
	}
	else
		return NULL;
}


void Kennel::ListAnimals()
{
	if(NumAnimals > 0)
		for(unsigned i = 0; i < MaxAnimals; i++)
		if(Residents[i] != NULL)
		{
			cout << "The animal in pen " << i + 1 << " says:" << endl;
			Residents[i]->WhoAmI();
		}
}

Dog d1("Rover");
Dog d2("Spot");
Dog d3("Chip");
Dog d4("Buddy");
Dog d5("Buntch");
Cat c1("Tinkerbell");
Cat c2("Inky");
Cat c3("Fluffy");
Cat c4("Princess");
Cat c5("Sylvester");
Pig p1("JJB");
Pig p2("BeiKey");

int main(void)
{
	Kennel K(20);
	K.Accept(&d1);
	unsigned c2pen = K.Accept(&c2);
	K.Accept(&d3);
	K.Accept(&c1);
	unsigned d4pen = K.Accept(&d4);
	K.Accept(&d5);
	K.Accept(&c5);
	K.Release(c2pen);
	K.Accept(&c4);
	K.Accept(&c3);
	K.Release(d4pen);
	K.Accept(&d2);
	K.Accept(&p2);
	K.Accept(&p1);
 	K.ListAnimals();
	return 0;
}
