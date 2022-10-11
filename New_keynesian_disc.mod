// ENDOGENOUS VARIABLES

var 
   x      $\hat{x}$ 
   pi     $\hat{\pi}$ 
   i      $\hat{i}$ u $\hat{u}$;

// EXOGENOUS VARIABLES

varexo 
   e_u    $\hat{\varepsilon^{u}}$ 
   e_pi   $\hat{\varepsilon}^{\pi}$;

// PARAMETERS

parameters 
   beta      $\beta$ 
   kappa     $\kappa$ 
   sigma     $\sigma$ 
   omega     $\omega$ 
   eta       $\eta$ 
   rho_pi    $\rho_{\pi}$ 
   rho_u     $\rho_u$ 
   lambda_x  $\lambda_x$ 
   lambda_pi $\lambda_{\pi}$;

beta     = 0.99;
sigma    = 1.5;
omega    = 0.6;
eta      = 1.5;

/*
The parameter kappa is a function of other
parameters. You don't need to give it a value. 
Instead, we write it in its functional form.
*/

kappa    = (sigma+eta)*((1-omega)*(1-beta*omega))/omega;
rho_pi   = 1.5;
rho_u    = 0.8;
lambda_x = 1;
lambda_pi= 1;

// MODEL DECLARATION

model(linear);

// IS CURVE

x = x(+1) - (1/sigma) * (i - pi(+1)) + u;

// NKPC

pi = beta * pi(+1) + kappa * x + e_pi;

// SHOCKS

u = rho_u * u(-1) + e_u;

end;

// INITIAL VALUE OF ENDOGENOUS VARIABLES

initval;

x   = 0;
pi  = 0;
i   = 0;
u   = 0;

end;

//steady;

//check;

// THE SHOCKS BLOCK

shocks;

var    e_u;

stderr 0.01;

var    e_pi;

stderr 0.01;

end;

// MONETARY POLICY

planner_objective (lambda_x * x^2 + lambda_pi * pi^2);
discretionary_policy(periods=10092,irf=20,drop=1000, planner_discount=beta, instruments=(i), maxit=50000, nodisplay, noprint);
