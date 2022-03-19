import numpy as np
from geneticalgorithm import geneticalgorithm as ga

# copied from 'https://pypi.org/project/geneticalgorithm/'
algorithm_param = {'max_num_iteration': None,
                   'population_size': 100,
                   'mutation_probability': 0.1,
                   'elit_ratio': 0.01,
                   'crossover_probability': 0.5,
                   'parents_portion': 0.3,
                   'crossover_type': 'uniform',
                   'max_iteration_without_improv': None}


def constraints(fourWheel, type, skibag, fuel, pdc):
    # c1
    count = 0
    if fourWheel and type == 3:
        count += 1
    # c2
    if skibag and type != 0:
        count += 1
    # c3
    if fuel == 0 and type == 0:
        count += 1
    # c4
    if fuel == 1 and type != 3:
        count += 1
    # c5
    if fuel != 3 and type == 0:
        count += 1
    # c6
    # c7
    # c8
    # c9
    # c10
    return count


def f(X):
    value = constraints(X[3], X[0], X[2], X[1], X[4])

    return value


# array value in the following order: 'type','fuel','skibag','4-wheel','pdc'.
varbound = np.array([[0, 3], [0, 2], [0, 1], [0, 1], [0, 1]])


model = ga(function=f, dimension=5 variable_type='int', variable_boundaries=varbound, parma=algorithm_param)

model.run()
