import numpy as np
from geneticalgorithm import geneticalgorithm as ga

def f(X):

    type = X[0] 
    fuel =X[1]
    skibag = X[2]
    fourWheel = X[3]
    pdc =  X[4]

    reward = 5 
    
    # c1
    # 4wheel -> xdrive
    if fourWheel != 1 or type == 4:
        reward -= 1
    # c2
    # skipag -> !city
    if skibag != 1  or type != 1:
        reward -= 1
    # c3
    # fule = 4l -> city
    if fuel != 1 or type == 1:
        reward -= 1
    
    # c4
    # fule = 6l -> !xdrive
    if fuel != 2 or type != 4 :
        reward -= 1
    # c5
    # city -> fule != l0l 
    if type != 1 or fuel != 3:
        reward -= 1

    return reward


def printResult(X):
    type = X[0] 
    fuel =X[1]
    skibag = X[2]
    fourWheel = X[3]
    pdc =  X[4]

    print("Best Solution: ")

    if type == 1:
        print("city" ,end=", ")
    elif type == 2:
        print("limo",end=", ")
    elif type == 3:
        print("combi",end=", ")
    else:
        print("xdrive",end=", ")
            
    if fuel == 1:
        print("4l",end=", ")
    elif fuel == 2:
        print("6l",end=", ")
    else:
        print("10l",end=", ")

    if skibag == 1:
        print("skibag = yes",end=", ")
    else:
        print("skibag = no",end=", ")

    if fourWheel == 1:
        print("4wheel = yes",end=", ")
    else:
        print("4wheel = no",end=", ")

    if pdc == 1:
        print("pdc = yes")
    else:
        print("pdc = no")
    
    return None

# array values in the following order: 'type','fuel','skibag','4-wheel','pdc'.
varbound = np.array([[1, 4], [1,3], [0, 1], [0, 1], [0, 1]])

vartype = np.array([ ['int'], ['int'], ['int'], ['int'], ['int']])

model = ga(function=f, dimension=5, variable_boundaries=varbound, variable_type_mixed=vartype)

model.run()

printResult(model.best_variable)