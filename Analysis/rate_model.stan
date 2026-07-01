
data {
  int<lower=1> N;                // Number of observations
  int<lower=1> S;                // Number of subjects
  array[N] int<lower=1> subID;   // Subject ID for each observation
  int<lower=1> C;                // Number of conditions
  array[N] int<lower=1> condID;  // Condition ID for each observation
  array[N] int<lower=0> FC;      // Food choices (counts)
  array[N] int SC;               // Social choices (counts), allows non-positive for NA handling
}

parameters {
  // Parameters are now size 2*C to model both Food and Social responses
  matrix[2*C, S] z;                 // Standardized subject deviations
  cholesky_factor_corr[2*C] L_Omega;// Cholesky factor of the correlation matrix
  vector<lower=0>[2*C] tau;         // Scale parameters for varying effects
  row_vector[2*C] gamma;            // Population-level log-rates
  real<lower=0> overdisp;           // Overdispersion parameter for the negative binomial
}

transformed parameters {
  // Calculate subject-specific log-rates (beta) for each response type and condition
  matrix[S, 2*C] beta = rep_matrix(gamma, S) + (diag_pre_multiply(tau, L_Omega) * z)';
}

model {
  // --- Priors ---
  to_vector(z) ~ std_normal();
  L_Omega ~ lkj_corr_cholesky(2);
  tau ~ exponential(1.5);
  to_vector(gamma) ~ normal(1, 1.5); // Prior centered at log(2.7) choices
  overdisp ~ exponential(1);

  // --- Likelihood ---
  for (n in 1:N) {
    // Food choices are modeled for all conditions (parameters 1 through C)
    FC[n] ~ neg_binomial_2_log(beta[subID[n], condID[n]], overdisp);
    
    // Social choices are only modeled if they are not NA (passed as -1).
    // The parameters are offset by C (i.e., parameters C+1 through 2*C).
    if (SC[n] >= 0) {
      SC[n] ~ neg_binomial_2_log(beta[subID[n], condID[n] + C], overdisp);
    }
  }
}
