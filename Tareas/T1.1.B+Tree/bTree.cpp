#include<iostream>
using namespace std;

class BTNode{
	int *ArrKeys; 
	int deg;
    int num;
    bool hoja; 
	BTNode **C; 
	
public:
	BTNode(int _deg, bool _hoja);
	void insertarNonFull(int k);
	void separaDeNodo(int i, BTNode *y);
	void imprime();
	BTNode *buscar(int k); 
friend class BTree;
};

class BTree {
	BTNode *root; 
	int deg; 
public:
	BTree(int _deg){
        root = NULL; deg = _deg; 
    }
	void imprime(){
        if (root != NULL) {
            root->imprime(); 
        }
    }
	BTNode* buscar(int k){ 
        return (root == NULL)? NULL : root->buscar(k); 
    }
	void insertar(int k);
};

BTNode::BTNode(int deg1, bool hoja1){
	deg = deg1;
	hoja = hoja1;
	ArrKeys = new int[2*deg-1];
	C = new BTNode *[2*deg];
	num = 0;
}

void BTNode::imprime(){
	int i;
	for (i = 0; i < num; i++){
		if (hoja == false)
			C[i]->imprime();
		cout << " " << ArrKeys[i];
	}
	if (hoja == false){
        C[i]->imprime();
    }
		
}

BTNode *BTNode::buscar(int k)
{
	int i = 0;
	while (i < num && k > ArrKeys[i]){
        i++;
    }

	if (ArrKeys[i] == k){
        return this;
    }
		
	if (hoja == true){
        return NULL;
    }

	return C[i]->buscar(k);
}

void BTree::insertar(int k)
{
	if (root == NULL){
		root = new BTNode(deg, true);
		root->ArrKeys[0] = k; 
		root->num = 1;
	}
	else {
		if (root->num == 2*deg-1){
			BTNode *r = new BTNode(deg, false);
			r->C[0] = root;
			r->separaDeNodo(0, root);
			int i = 0;
			if (r->ArrKeys[0] < k){
                i++;
            }
			r->C[i]->insertarNonFull(k);
			root = r;
		}
		else {
            root->insertarNonFull(k);
        }
			
	}
}

void BTNode::insertarNonFull(int k){
	int i = num-1;
	if (hoja == true){
		while (i >= 0 && ArrKeys[i] > k){
			ArrKeys[i+1] = ArrKeys[i];
			i--;
		}
		ArrKeys[i+1] = k;
		num = num+1;
	}
	else{
		while (i >= 0 && ArrKeys[i] > k){
            i--;
        }
		if (C[i+1]->num == 2*deg-1){
			separaDeNodo(i+1, C[i+1]);
			if (ArrKeys[i+1] < k){
                i++;
            }		
		}
		C[i+1]->insertarNonFull(k);
	}
}

void BTNode::separaDeNodo(int i, BTNode *y){

	BTNode *z = new BTNode(y->deg, y->hoja);
	z->num = deg - 1;
	for (int j = 0; j < deg-1; j++){
        z->ArrKeys[j] = y->ArrKeys[j+deg];
    }

	if (y->hoja == false){
		for (int j = 0; j < deg; j++){
            z->C[j] = y->C[j+deg];
        }
	}

	y->num = deg - 1;

	for (int j = num; j >= i+1; j--){
        C[j+1] = C[j];
    }
	C[i+1] = z;

	for (int j = num-1; j >= i; j--){
        ArrKeys[j+1] = ArrKeys[j];
    }
	ArrKeys[i] = y->ArrKeys[deg-1];
	num = num + 1;
}

int main()
{
    int k;
	BTree prueba(3);
	prueba.insertar(100);
	prueba.insertar(80);
	prueba.insertar(54);
	prueba.insertar(38);
	prueba.insertar(92);
	prueba.insertar(300);
	prueba.insertar(789);
	prueba.insertar(500);
	prueba.insertar(110);
	prueba.insertar(230);
    prueba.insertar(900);

	cout << "El arbol final:  ";
	prueba.imprime();

	k = 230;
	(prueba.buscar(k) != NULL)? cout << "\nValor encontrado" : cout << "\nValor No encontrado" << endl;
	k = 54;
	(prueba.buscar(k) != NULL)? cout << "\nValor encontrado" : cout << "\nValor No encontrado" << endl;
    k = 690;
	(prueba.buscar(k) != NULL)? cout << "\nValor encontrado" : cout << "\nValor No encontrado" << endl;

	return 0;
}
