import numpy as np
from scipy.stats import linregress

# Your data
x = np.array([1 ,2 ,4 ,6,8])
y = np.array([5945.33,3652.85,2421.40,1878.72,1645.18  ])

# Linearize
log_x = np.log(x)
log_y = np.log(y)

# Linear regression on log-log
slope, intercept, r_value, p_value, std_err = linregress(log_x, log_y)


b = slope
a = np.exp(intercept)

print(f"Power-law fit: y = {a:.2f} * x^({b:.3f})")

# Fit 2nd-degree polynomial: y = ax² + bx + c
coeffs = np.polyfit(x, y, deg=2)
a, b, c = coeffs

print(f"Quadratic fit: y = {a:.2f} * x^2 + {b:.2f} * x + {c:.2f}")