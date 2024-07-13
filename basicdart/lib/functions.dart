void main(){
  hello();
  hello2('Robert');
  int sum = addNumber(10, 20);
  print(sum);
}

void hello(){
  print('Hello, Loong.');
}

void hello2(String name){
  print('Hello, $name.');
}

int addNumber(int x, int y){
  return x + y;
}