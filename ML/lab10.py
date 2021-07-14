#Fitting to Give n Ploynomial Of degree 1 (Linear Regression)
from math import ceil
import numpy as np
from scipy import linalg  

 
def lowess(x, y, f= 2. / 3., iter=3):
    
    n = len(x) # Number of x  points 
    r = int(ceil(f * n))  # Computing the residual of smoothing functions 
    h = [np.sort(np.abs(x - x[i]))[r] for i in range(n)] # 
    w = np.clip(np.abs((x[:, None] - x[None, :]) / h), 0.0, 1.0)  # Weight Function 
    w = (1 - w ** 3) ** 3  # Tricube Weight Function
    ypred = np.zeros(n) # Initialisation of predictor 
    delta = np.ones(n)  # Initialisation of delta
   
    for iteration in range(iter):
        for i in range(n):
            weights = delta * w[:, i] # Cumulative Weights 
            b = np.array([np.sum(weights * y), np.sum(weights * y * x)]) # Matrix B
            A = np.array([[np.sum(weights), np.sum(weights * x)],
                          [np.sum(weights * x), np.sum(weights * x * x)]]) # Matrix A
                      
            beta = linalg.solve(A, b) # Beta,Solution of AX= B equation 
            ypred[i] = beta[0] + beta[1] * x[i]
             
        residuals = y - ypred   # Finding Residuals
        s = np.median(np.abs(residuals))  # Median of Residuals
        delta = np.clip(residuals / (6.0 * s), -1, 1)  # Delta
        delta = (1 - delta ** 2) ** 2   # Delta 
 
    return ypred
 
if __name__ == '__main__':  # Main Function
    
    import math
    
    n = 100  # Number of data points
   
    #Case1: Sinusoidal Fitting 
    x = np.linspace(0, 2 * math.pi, n)
    print(x)
    y = np.sin(x) + 0.3 * np.random.randn(n) 
    
    #Case2 : Straight Line Fitting
    #x=np.linspace(0,2.5,n) # For Linear
    #y= 1 + 0.25*np.random.randn(n) # For Linear
    
    f = 0.25
    ypred = lowess(x, y, f=f, iter=3)
    
    import pylab as pl
    pl.clf()
    pl.plot(x, y, label='Y NOISY')
    pl.plot(x, ypred, label='Y PREDICTED')
    pl.legend()
    pl.show()